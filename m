Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4F7D2555
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVSey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 14:34:54 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B85E0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 11:34:52 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 82DD5B8005C
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 18:34:50 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.115.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0A77713C2B0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 11:34:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0A77713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1697999690;
        bh=zwvcj8Jts0+dAn/IWXxTID2MWsJtS5ffODHKPCrSO68=;
        h=To:From:Subject:Date:From;
        b=U6YsFz9X8UzXfgWk+mNiE4+EnlNP7OdZ0KMOBlB5AT1nDfVFPvgh2GC9AHk6+9IZl
         wNhSMRulh2PU5aq3jzB014gMXfAbqSP6oRtuCBBLsN904sSG6Jk2rrCmMtnmfnwCC/
         ogZoGSY0N7BInpmmeaB798/SPrQamxwwPvUHSJto=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi warnings with be200 radio
Organization: Candela Technologies
Message-ID: <66775882-e01d-f17a-8ef3-61346ff43c18@candelatech.com>
Date:   Sun, 22 Oct 2023 11:34:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1697999691-2yFN6Zi2nZGp
X-MDID-O: us5;ut7;1697999691;2yFN6Zi2nZGp;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I've been testing a modified tree rebased on top of wireless-next.

I see these errors related to iwlwifi in the logs:

iwlwifi 0000:0c:00.0: Not associated and the session protection is over already...
iwlwifi 0000:09:00.0: Not associated and the session protection is over already...

and

iwlwifi 0000:0a:00.0: WRT: Invalid buffer destination: 0

I added that ": %d' to the buffer destination so that we'd know what is
the invalid value.  This one seems to happen on startup of the radios.
My guess is that it is not harmful, as system seems to mostly run OK.

FW version is v83.

My tree is patched up to all the iwlwifi patches I found on the mailing list before today's
batch.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
