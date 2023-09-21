Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074B7A9DC4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjIUTrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIUTrJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831519ECC
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eMZwRFUJR+1f8odoOkydB8uoU5SbHH/ZVIYDxrngU2U=;
        t=1695324573; x=1696534173; b=TPQlQ8XOCXGU+HN2UIK+G1uXuyI1lXkb12HAhVAkUzAhanY
        7Z5FguAN4CHK+bQCL58i+2wbSk5o4rj3JpRxcgTrYyIffZLGZqcYNFjqssSbRtuI9Ydd2+lTCX6V7
        6g3zvzeJm57/BTsvYtBF3hKkZzBFEmvdmbW+aKU2ala8q/yHv8hG+as5r6m8U7Fz1KYTIZPkC3AAn
        rj526ay2+b+e1iZefMsdyL89vYwEV8X2HNsVWOlQZ3dtSWuTKCyt9/SJdQGLLbLD2j4GTKYrQPycf
        Q3xueDbmm38iYzBds7lrXoJhqd1kNUiKt5WdbY0Zf8fYh4DSRmKYqDGARf8z1jLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjPMg-00DhQV-0t;
        Thu, 21 Sep 2023 21:29:30 +0200
Message-ID: <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
Subject: Re: Microcode SW error since Linux 6.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Antoine =?ISO-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
        linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>, ilan.peer@intel.com
Date:   Thu, 21 Sep 2023 21:29:27 +0200
In-Reply-To: <87ttrncuc8.fsf@angela.anarc.at>
References: <87ttrncuc8.fsf@angela.anarc.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-09-21 at 13:24 -0400, Antoine Beaupr=C3=A9 wrote:
> Hi,
>=20
> I've found what I feel might be a regression between Linux 6.1 and
> 6.5. For other reasons, I upgraded the kernel on my Debian 12
> ("bookworm", stale) laptop from the distribution 6.1.52 to the unstable
> ("sid") version, 6.5.3.
>=20
> After the upgrade, I started to notice stuttering in my audio player, I
> tracked it down and managed to correlate it with some kernel errors
> related to the iwlwifi driver.
>=20
> What's interesting is that this happens regardless of whether or not the
> NIC is connected to a network. In at least one of the traces, the
> computer was connected over a wire and wireless was not associated in
> Network Manager.

This happens when scanning.


> Here's an example of the problem:
>=20
> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Microcode SW error d=
etected. Restarting 0x0.

Can you give a few wpa_supplicant lines (there were some below) above
this? Just want to make sure it really is scanning on wlan0, not
something with P2P device.

> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x20103600 | ADVANCE=
D_SYSASSERT

> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x000000FF | umac da=
ta1

This means that somehow scan_start_mac_or_link_id in the driver ended up
0xff which is invalid, but I'm not sure I see immediately how that
happened, since it looks like in 6.5.3 we do assign it reasonably. I
guess somehow in the code link_info->fw_link_id must be 0xff (invalid
ID), but I'm not sure I see how that could happen.

*thinks*

Oh.. This is an older firmware, so it doesn't have
IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT! Hah. I feel like I had some concerns
in this area before ... but maybe the other way around.

I think something like this, perhaps:

--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2342,7 +2342,7 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *=
mvm,
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
 		gp->num_of_fragments[SCAN_HB_LMAC_IDX] =3D IWL_SCAN_NUM_OF_FRAGS;
=20
-	if (version < 12) {
+	if (version < 12 || !iwl_mvm_has_mld_api(mvm->fw)) {
 		gp->scan_start_mac_or_link_id =3D scan_vif->id;
 	} else {
 		struct iwl_mvm_vif_link_info *link_info;

johannes
