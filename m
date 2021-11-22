Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9164A4594DF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhKVSqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:46:37 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:54815 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhKVSqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:46:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637606609; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=a26SQS1687vHlVe05N9hhrdCWCTfJUZ00yGt4HUdb7U=;
 b=anfOcm5fJQnQcbe1t6hRjfufbpgxkfGYSl5D95f3T4JvHIXQok0IAcqOURs0CuAI1PbICu/Z
 +7lR368wifTbl+4rA/+ABN7iFRLKXm4ZzR4w42HPHhsYvtJM/uE4g+I7ZUSyYsyETCa3Kw8d
 +TXoCX4CvsY6uNFVPc2xdwLNxbI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 619be4d1db3ac5552acce2d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 18:43:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61A0DC43616; Mon, 22 Nov 2021 18:43:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 975C6C4338F;
        Mon, 22 Nov 2021 18:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 975C6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: mt7915: fix NULL pointer dereference in
 mt7915_get_phy_mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
References: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163760660589.7371.15128579230580429492.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 18:43:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following NULL pointer dereference in mt7915_get_phy_mode
> routine adding an ibss interface to the mt7915 driver.
> 
> [  101.137097] wlan0: Trigger new scan to find an IBSS to join
> [  102.827039] wlan0: Creating new IBSS network, BSSID 26:a4:50:1a:6e:69
> [  103.064756] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  103.073670] Mem abort info:
> [  103.076520]   ESR = 0x96000005
> [  103.079614]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  103.084934]   SET = 0, FnV = 0
> [  103.088042]   EA = 0, S1PTW = 0
> [  103.091215] Data abort info:
> [  103.094104]   ISV = 0, ISS = 0x00000005
> [  103.098041]   CM = 0, WnR = 0
> [  103.101044] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000460b1000
> [  103.107565] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [  103.116590] Internal error: Oops: 96000005 [#1] SMP
> [  103.189066] CPU: 1 PID: 333 Comm: kworker/u4:3 Not tainted 5.10.75 #0
> [  103.195498] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [  103.201124] Workqueue: phy0 ieee80211_iface_work [mac80211]
> [  103.206695] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
> [  103.212705] pc : mt7915_get_phy_mode+0x68/0x120 [mt7915e]
> [  103.218103] lr : mt7915_mcu_add_bss_info+0x11c/0x760 [mt7915e]
> [  103.223927] sp : ffffffc011cdb9e0
> [  103.227235] x29: ffffffc011cdb9e0 x28: ffffff8006563098
> [  103.232545] x27: ffffff8005f4da22 x26: ffffff800685ac40
> [  103.237855] x25: 0000000000000001 x24: 000000000000011f
> [  103.243165] x23: ffffff8005f4e260 x22: ffffff8006567918
> [  103.248475] x21: ffffff8005f4df80 x20: ffffff800685ac58
> [  103.253785] x19: ffffff8006744400 x18: 0000000000000000
> [  103.259094] x17: 0000000000000000 x16: 0000000000000001
> [  103.264403] x15: 000899c3a2d9d2e4 x14: 000899bdc3c3a1c8
> [  103.269713] x13: 0000000000000000 x12: 0000000000000000
> [  103.275024] x11: ffffffc010e30c20 x10: 0000000000000000
> [  103.280333] x9 : 0000000000000050 x8 : ffffff8006567d88
> [  103.285642] x7 : ffffff8006563b5c x6 : ffffff8006563b44
> [  103.290952] x5 : 0000000000000002 x4 : 0000000000000001
> [  103.296262] x3 : 0000000000000001 x2 : 0000000000000001
> [  103.301572] x1 : 0000000000000000 x0 : 0000000000000011
> [  103.306882] Call trace:
> [  103.309328]  mt7915_get_phy_mode+0x68/0x120 [mt7915e]
> [  103.314378]  mt7915_bss_info_changed+0x198/0x200 [mt7915e]
> [  103.319941]  ieee80211_bss_info_change_notify+0x128/0x290 [mac80211]
> [  103.326360]  __ieee80211_sta_join_ibss+0x308/0x6c4 [mac80211]
> [  103.332171]  ieee80211_sta_create_ibss+0x8c/0x10c [mac80211]
> [  103.337895]  ieee80211_ibss_work+0x3dc/0x614 [mac80211]
> [  103.343185]  ieee80211_iface_work+0x388/0x3f0 [mac80211]
> [  103.348495]  process_one_work+0x288/0x690
> [  103.352499]  worker_thread+0x70/0x464
> [  103.356157]  kthread+0x144/0x150
> [  103.359380]  ret_from_fork+0x10/0x18
> [  103.362952] Code: 394008c3 52800220 394000e4 7100007f (39400023)
> 
> Fixes: 37f4ca907c46 ("mt76: mt7915: register per-phy HE capabilities for each interface")
> Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

6e53d6d26920 mt76: mt7915: fix NULL pointer dereference in mt7915_get_phy_mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

