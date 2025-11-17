Return-Path: <linux-wireless+bounces-29054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD1C655BA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BDE2D29F00
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6633B973;
	Mon, 17 Nov 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="lV4klJot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E00307AEE
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398991; cv=none; b=bRLuIY+3tNa4p9QZ8OyzTdd5+TJF6bMv9Av2ytHX7CJGuMKvmmvc+s54PxCjKjp3vsParyrHm1DUXkR6IcxaTYFM9XYSzJqQAEUi3u/odcp95RQku6FR9/Y2eM30+yWXQW0HaCOLfoSVguwBV5Rl0Gp6lbzQ6LdqmMdV2UQzCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398991; c=relaxed/simple;
	bh=GQ2l1FtCQk8a5A/D6+r+0V3xCadwcOHKmikQp/6m8Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/xNjvoJKR2ygAcKyJOOZ3us9gRShKVu36MwFADJocEMR5TwM/1wNBaBpo2mT3/QNDppMJLxFzJpVl/i7hBzQBrM6s19d8O4yMt/2mjlug59qd8hj69g9+Yz9ELXWMG2jikJ9Z+8k6A3eicsmv2aBDbUnkMVEs7u1WvCsJNk3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=lV4klJot; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 05118C400A3;
	Mon, 17 Nov 2025 17:02:55 +0000 (UTC)
Received: from [172.18.0.200] (unknown [64.190.177.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8702213C2B5;
	Mon, 17 Nov 2025 09:02:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8702213C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1763398959;
	bh=GQ2l1FtCQk8a5A/D6+r+0V3xCadwcOHKmikQp/6m8Jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lV4klJotUTpo5zZioJImRUnz4+PgMWxD09OsZg5+JbtOusDqQ2VrYm9wfUgc3Ij1c
	 PZ/XVJvrzAHl3AlyZ16aIdoRpHC3KtbaFsdE8YsHfcsoKnGLtiXwLvSY7wXIqL62ny
	 5jDDkBVVsGAnftytdwSNiEUzjJ7eLDAlOPdcONag=
Message-ID: <49fdf52b-32cb-427e-ab95-a81856840a1e@candelatech.com>
Date: Mon, 17 Nov 2025 09:02:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76] wifi: mt76: mt7996: Do not run ieee80211_iter_keys()
 for scanning links in mt7996_vif_link_remove()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251115-mt7996-key-iter-link-remove-fix-v1-1-4f3f4e1eaa78@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20251115-mt7996-key-iter-link-remove-fix-v1-1-4f3f4e1eaa78@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1763398977-UsmcDBX0i5jE
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1763398977;UsmcDBX0i5jE;<greearb@candelatech.com>;40f3b03bb24907b736a33b345f288e14
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/15/25 2:41 AM, Lorenzo Bianconi wrote:
> mt7996_vif_link_remove routine is executed by mt76_scan_complete()
> without holding the wiphy mutex triggering the following lockdep warning.

Hello Lorenzo,

Thank you for the patch.  This appears to fix the lockdep splats I was
seeing, and kernel is stable in at least initial testing.

Thanks,
Ben

> 
>   WARNING: CPU: 0 PID: 72 at net/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
>   CPU: 0 UID: 0 PID: 72 Comm: kworker/u32:2 Tainted: G S                  6.18.0-rc5+ #27 PREEMPT(full)
>   Tainted: [S]=CPU_OUT_OF_SPEC
>   Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>   Workqueue: phy3 mt76_scan_work [mt76]
>   RIP: 0010:ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
>   Code: 4c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 b4 eb 1e e1 85 c0 0f 85 49
> ff ff ff 4c 8b ab 90 1a 00 00 48 8d 83 90
>   RSP: 0018:ffffc900002f7cb0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff888127e00ee0 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888127e00788 RDI: ffff88811132b5c8
>   RBP: ffffffffa0ddf400 R08: 0000000000000001 R09: 000000009dcc1dac
>   R10: 0000000000000001 R11: ffff88811132b5a0 R12: ffffc900002f7d00
>   R13: ffff8882581e6a80 R14: ffff888127e0afc8 R15: ffff888158832038
>   FS:  0000000000000000(0000) GS:ffff8884da486000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000030a0fd90 CR3: 0000000002c52004 CR4: 00000000003706f0
>   Call Trace:
>    <TASK>
>    ? lock_acquire+0xc2/0x2c0
>    mt7996_vif_link_remove+0x64/0x2b0 [mt7996e]
>    mt76_put_vif_phy_link+0x41/0x50 [mt76]
>    mt76_scan_complete+0x77/0x100 [mt76]
>    mt76_scan_work+0x2eb/0x3f0 [mt76]
>    ? process_one_work+0x1e5/0x6d0
>    process_one_work+0x221/0x6d0
>    worker_thread+0x19a/0x340
>    ? rescuer_thread+0x450/0x450
>    kthread+0x108/0x220
>    ? kthreads_online_cpu+0x110/0x110
>    ret_from_fork+0x1c6/0x220
>    ? kthreads_online_cpu+0x110/0x110
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   irq event stamp: 45471
>   hardirqs last  enabled at (45477): [<ffffffff813d446e>] __up_console_sem+0x5e/0x70
>   hardirqs last disabled at (45482): [<ffffffff813d4453>] __up_console_sem+0x43/0x70
>   softirqs last  enabled at (44500): [<ffffffff81f2ae0c>] napi_pp_put_page+0xac/0xd0
>   softirqs last disabled at (44498): [<ffffffff81fa32a0>] page_pool_put_unrefed_netmem+0x290/0x3d0
>   ---[ end trace 0000000000000000 ]---
> 
> Fix the issue skipping ieee80211_iter_keys() for scanning links in
> mt7996_vif_link_remove routine since we have not uploaded any hw keys
> for these links.
> 
> Fixes: 04414d7bba78 ("wifi: mt76: mt7996: delete vif keys when requested")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 2a45db398fd597180c0b2bfc12e019b514f24fd6..beed795edb24c67e1b7b44fe87fd5de125a21d94 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -392,7 +392,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
>   	};
>   	int idx = msta_link->wcid.idx;
>   
> -	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
> +	if (!mlink->wcid->offchannel)
> +		ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
>   
>   	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
>   			   CONN_STATE_DISCONNECT, false);
> 
> ---
> base-commit: 09600421ffe2acc1a00ec466b25485f11b6bb957
> change-id: 20251115-mt7996-key-iter-link-remove-fix-7cf4d529c5a0
> 
> Best regards,


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

