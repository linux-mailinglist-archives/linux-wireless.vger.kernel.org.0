Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748C7E8218
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjKJS6B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjKJS5u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:57:50 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14837FE9
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 10:20:14 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 84AF6302E28
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 18:19:25 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E4EED6C005D
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 18:19:13 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3A08713C2B0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 10:19:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3A08713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699640353;
        bh=2D3e5Uo7Q58bQa3dF1x8sdWspElXIiSiWrYY8tdXlgY=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=VLtpTa6OSJhbLwIrwTBydkSj5Vpzq6/TMQVC677pbTydSVJlWBovK5Y3Zgs0IMWPq
         oWt5WILReOkTGQh/4FOtEAgENkp+IgTMc6kQc3puoJ30Y6WmX/fIGiqfYa4azcPMOv
         TXf2A7CfLFvGwTNw80mlnbIH7HRXGUFIUjA05MFw=
Message-ID: <c1e04d01-3560-0842-376a-af7a5534aeb5@candelatech.com>
Date:   Fri, 10 Nov 2023 10:19:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: KASAN memory detection problem with be200 in 6.7 + hacks.
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <232e7566-36b0-a669-5b3f-71c8862b454b@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <232e7566-36b0-a669-5b3f-71c8862b454b@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1699640354-zAcge4TftNST
X-MDID-O: us5;at1;1699640354;zAcge4TftNST;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/9/23 17:01, Ben Greear wrote:
> So, this log is huge.  The problem could easily start with the firmware crash,
> though not certain of that.  I have a bunch of radios attempting to associate,
> in order to reproduce the problems faster, but a single radio will cause the same
> or similar issue after some time.

[snip big bug report]

I am thinking the problem I hit might originate in this code below.

The radio's firmware has crashed and/or is bugging at this point,
user-space is trying to admin down the wlan.  But, the code below
probably restores the configuration instead of actually cleaning
it up as expected.

So maybe we need at least option to not roll back to the old config in
cases where we really need to clean things up?

	ret = ieee80211_check_dup_link_addrs(sdata);
	if (!ret) {
		/* for keys we will not be able to undo this */
		ieee80211_tear_down_links(sdata, to_free, rem);

		ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);

		/* tell the driver */
		ret = drv_change_vif_links(sdata->local, sdata,
					   old_links & old_active,
					   new_links & sdata->vif.active_links,
					   old);
		if (!new_links)
			ieee80211_debugfs_recreate_netdev(sdata, false);
	}

	if (ret) {
		sdata_info(sdata, "vif-update-links, error applying links: %d  Restoring old configuration, links: 0x%x  dormant_links: 0x%x\n",
			   ret, old_links, dormant_links);
		/* restore config */
		memcpy(sdata->link, old_data, sizeof(old_data));
		memcpy(sdata->vif.link_conf, old, sizeof(old));
		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
		/* and free (only) the newly allocated links */
		memset(to_free, 0, sizeof(links));
		goto free;
	}


Thanks,
Ben

