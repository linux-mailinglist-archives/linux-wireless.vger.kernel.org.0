Return-Path: <linux-wireless+bounces-32088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mApBNfbOm2lH7gMAu9opvQ
	(envelope-from <linux-wireless+bounces-32088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:52:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B31171B41
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B0A300C019
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A3B344050;
	Mon, 23 Feb 2026 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VlTjzR0q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D33446B7;
	Mon, 23 Feb 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818739; cv=none; b=IC2LMgPxW1Uyv7rJ9glqenb3jWRIIwj6jlYyfXTyn7deD7x3GjUyE89hwgMWy+6naPXrat4/UQiowWoyMpB0WPb9RppRKKOW6mIRK7LrMuTQsvFOP+VF9f+zarfaruzUg8iryTQju+W+jtvCb+E8NDhlXovlOrMru8z0QAxyNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818739; c=relaxed/simple;
	bh=z/ZOtTSKlS1MLOJr93pP/wcSbTspQJ2VQe8FW/XuzPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYsSeMBTXYHEoOY8JzOlRJTogVkq8MBCj4bK568poYL3X5B3RjHCtDZYUGpgdx5bGkXWrQzj0tTPAN6iVvCLPOz7PNqcJYnCNVPDbLiRp8FRSPyCkBK5/5g1v0lWeS4YpU6L96IHVl6vAJ0vynwu1RzFGbQXQnVK/P/hf2EsCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VlTjzR0q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61N3q9hK5159246, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1771818729; bh=tay5HRuhhv1b9P0/unPr/qbbQsYmRQTqTXbll0GX5a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VlTjzR0qV1EReTWKR1Y4qhT2OUuVctkmNVmY70ptczB5aWHsG6dklbbIoEc1EUVW7
	 xBjsNB7+Cd7m61QAslIT5013mnUfDwyc+//hqyM6hPh6X4DUXLJmoQ7BqlN+t1T7OR
	 6EMsHXJhOGXXCjErOLBuJQR4vSIPKL/ICFpEv163mN9k8NPJpKZ1cL1TnjgE5aqis5
	 Sq5Po0cEbuj/Ac5AGq1gzRwiKhAbnkE+qT5eF/W3eutKnMTLGV92xjvtx2WNy6QE28
	 RLRDfRjqywrourKS85ywZR7eq86J0aSRosIyLy2S3ySH/BT4H/bVx/XQm7kgG6hzwp
	 a+T+QltTG0icA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61N3q9hK5159246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:52:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Feb 2026 11:52:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 23 Feb 2026 11:52:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Duoming Zhou <duoming@zju.edu.cn>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless] rtlwifi: rtl_pci: Fix possible use-after-free
 caused by unfinished tasklet
Thread-Topic: [PATCH wireless] rtlwifi: rtl_pci: Fix possible use-after-free
 caused by unfinished tasklet
Thread-Index: AQHcpHKGfjGTFjWNT0uYEj5lDUOgdbWPpOsA
Date: Mon, 23 Feb 2026 03:52:10 +0000
Message-ID: <153117a9fd5b464baa77b5ef48daaabc@realtek.com>
References: <20260223031415.39221-1-duoming@zju.edu.cn>
In-Reply-To: <20260223031415.39221-1-duoming@zju.edu.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32088-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 39B31171B41
X-Rspamd-Action: no action

Duoming Zhou <duoming@zju.edu.cn> wrote:
> The irq_prepare_bcn_tasklet is initialized in rtl_pci_init() and
> scheduled when RTL_IMR_BCNINT interrupt is triggered by hardware.
> But it is never killed in rtl_pci_deinit(). When the rtlwifi card
> probe fails or is being detached, the ieee80211_hw is deallocated.
> However, irq_prepare_bcn_tasklet may still be running or pending,
> leading to use-after-free when the freed ieee80211_hw is accessed
> in _rtl_pci_prepare_bcn_tasklet().
>=20
> Similar to irq_tasklet, add tasklet_kill() in rtl_pci_deinit() to
> ensure that irq_prepare_bcn_tasklet is properly terminated before
> the ieee80211_hw is released.
>=20
> The issue was identified through static analysis.
>=20
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

The tree selection should be "rtw-next" (may be "rtw", but I don't think
this patch is urgent), and subject prefix should be "wifi: rtlwifi: ...".
More, I'd point out the name of tasklet in subject. Then,
"[PATCH rtw-next] wifi: rtlwifi: pci: fix possible use-after-free caused by=
 unfinished irq_prepare_bcn_tasklet"

Otherwise, looks good to me.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index d080469264c..f0010336e78 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -1674,6 +1674,7 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
>=20
>         synchronize_irq(rtlpci->pdev->irq);
>         tasklet_kill(&rtlpriv->works.irq_tasklet);
> +       tasklet_kill(&rtlpriv->works.irq_prepare_bcn_tasklet);
>         cancel_work_sync(&rtlpriv->works.lps_change_work);
>  }
>=20
> --
> 2.34.1


