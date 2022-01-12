Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0DD48C005
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiALIem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 03:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiALIem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 03:34:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBFC06173F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nVHkZ32N5JIE6MtYkG+nUBR4O2I95Tws5RcRm6tJH+c=;
        t=1641976482; x=1643186082; b=U2tSlrstUOrts11WYsCC1m6qoQXwcV6Mn1jAFgy7t5c8bGD
        DYwDp/myLzxCjQHd6vK4goATHQUj8Rwh6htsyajvLucsk3bIgqJURIJKjPtVgsyXekniq8LrxyACZ
        oYo2Q0PkIhCjcWFGsHWtT4NdU9u/yQIWKiqKDMbC1rWxsqpNyPsYUQ1Z6QJpE3sPJS4dqLMsOoAHx
        en3Qwsc79uQw/mTKw5FCcceiMnFmCup7ixcGft3uOk/GAZZHpUqIq4AMNMRFDlzSx97CclFsqQuMl
        6F3ZxjiueJPvzSuF1NG3j+FkM1msptY4gv6GD7450jiCqRSDZ2cGIOMuRm0db1jQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n7Z5Y-004j9y-8g;
        Wed, 12 Jan 2022 09:34:36 +0100
Message-ID: <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Len Brown <lenb@kernel.org>, Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 12 Jan 2022 09:34:35 +0100
In-Reply-To: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-01-11 at 20:47 -0500, Len Brown wrote:
> 
> I recently installed Fedora 35, and the card worked fine.
> But when I built and booted a 5.15 or 5.16 upstream kernel from src,
> the card fails at initialization and I've not found a way to revive it.
> (dmesg below)

Ouch.

> [   11.411533] iwlwifi 0000:3a:00.0: Loaded firmware version: 17.3216344376.0 3160-17.ucode
> [   11.412815] iwlwifi 0000:3a:00.0: 0x00000038 | BAD_COMMAND

...

> [   11.688317] iwlwifi 0000:3a:00.0: FW error in SYNC CMD PER_CHAIN_LIMIT_OFFSET_CMD

Looks like somehow this slipped through and we're sending a new command
with an old firmware.


Something like this might help?

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 7ee4802a5ef1..56b9363a9111 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1026,7 +1026,9 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-	if (cmd_ver == 5) {
+	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN) {
+		return 0;
+	} else if (cmd_ver == 5) {
 		len = sizeof(cmd.v5);
 		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
 		n_profiles = ACPI_NUM_GEO_PROFILES_REV3;


Luca, are you aware of anything in this area?

johannes
