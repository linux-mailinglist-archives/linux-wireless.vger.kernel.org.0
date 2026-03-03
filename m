Return-Path: <linux-wireless+bounces-32371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMPlJvlNpmlCNwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:56:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B571E842B
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB94D30360AE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858B379EF7;
	Tue,  3 Mar 2026 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="X8tNa3KB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA6379EC5;
	Tue,  3 Mar 2026 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506612; cv=none; b=mXv8tiBQNU+SrKGn0c5x9OY0IBJOU8uR1VF/AnXZWR7nHRGE6vjJXy0EIEwhh7TAtEuugIyR91jGglNEqzn3l62da9lDmsFr5w0bXmw0/nmsgpM9E7OMcRn96+T9+yDdc0YVb964GqYQSB1HWb8JMFjiHktKLh2iDPZA6ggprKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506612; c=relaxed/simple;
	bh=qnJlLiL0AcIcsaRAkmGz9P8Q6KwVX87MN/HDYFurUR0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=JPWbLqypblhcxSxUT2T/wzFBvuDEi0gTN3UxLKfNTexeeNq82jP8pEFDxoT/G2SsbbNpdVoxpvLfFxLVzFx+BBl2UMAcrBAErpP/0JMQ8cYCSZIxMy3l+TfvGzKZQ4WzzMluJBTuCYt3MLIWQ5DlS/zi05YVqYhCZtGk4dqcIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=X8tNa3KB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6232ukO13283773, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772506606; bh=cbcUVwR3CVzGweORd951qxLJZunGzC94QcYNLYu2fe0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=X8tNa3KBNGZYw9uqfAHGDxNznNwk5AQslSFKgAeVYoNxqCLjqnC6DTwz/7YX7nMxY
	 AeBnHb3WH/V/f8wb+N+LYZj4RBW9YWB7AmjTq1wWcyYfxEra7obC0ykiO7axAbY4GT
	 Bt1oZLCgEh4eSpHR8MO4cH7LShhzv0VQmlRRWzm9CAW9V4CTkX0iRwmUxW452bUwzC
	 MFCgS5NjKm3nmg1Fof2+dyRgLaiKnCWh1NCzihUtePDvSm/27CWfQ7cEWwM5OXAsbG
	 bW/0+qmz0FBHmsSWQeIqIgFm4u7dioqwmsE9eDrYurW4Wq6ZavXOCrQ8B3dSVn0V0B
	 +nOv9CYa1D+nQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6232ukO13283773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 10:56:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 3 Mar 2026 10:56:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:56:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Duoming Zhou <duoming@zju.edu.cn>, <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pkshih@realtek.com>,
        Duoming Zhou
	<duoming@zju.edu.cn>
Subject: Re: [PATCH rtw-next v2] wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
In-Reply-To: <20260223045522.48377-1-duoming@zju.edu.cn>
References: <20260223045522.48377-1-duoming@zju.edu.cn>
Message-ID: <74e1fcf4-5991-4b93-86e3-398ad8bfe233@RTKEXHMBS05.realtek.com.tw>
Date: Tue, 3 Mar 2026 10:56:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 11B571E842B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32371-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,RTKEXHMBS05.realtek.com.tw:mid,zju.edu.cn:email]
X-Rspamd-Action: no action

Duoming Zhou <duoming@zju.edu.cn> wrote:

> The irq_prepare_bcn_tasklet is initialized in rtl_pci_init() and
> scheduled when RTL_IMR_BCNINT interrupt is triggered by hardware.
> But it is never killed in rtl_pci_deinit(). When the rtlwifi card
> probe fails or is being detached, the ieee80211_hw is deallocated.
> However, irq_prepare_bcn_tasklet may still be running or pending,
> leading to use-after-free when the freed ieee80211_hw is accessed
> in _rtl_pci_prepare_bcn_tasklet().
> 
> Similar to irq_tasklet, add tasklet_kill() in rtl_pci_deinit() to
> ensure that irq_prepare_bcn_tasklet is properly terminated before
> the ieee80211_hw is released.
> 
> The issue was identified through static analysis.
> 
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

039cd522dc70 wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet

---
https://github.com/pkshih/rtw.git


