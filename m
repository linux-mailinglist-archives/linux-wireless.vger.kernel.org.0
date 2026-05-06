Return-Path: <linux-wireless+bounces-35993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIfnGoX0+mn/UgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:57:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D614D7821
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A876300B513
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A783DE42C;
	Wed,  6 May 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="I9mNZXHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253C3E022A
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054272; cv=none; b=eok5yDvT3SVq1iySMCvm9aU3mWWyIE15Fpaw2QpMjqnqTho+qqlcGF0X7KNLogszVgrL+czecN6EIBYS0TeHRv+G24lawHh1WgcaSdKENj6b8+HjPeKxC2NjAq8JVKufnCc+AYeGzBvl6AFvP0NFn6rAFoV7NFtXOfDfBPumZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054272; c=relaxed/simple;
	bh=wbDVga/x7xMy/35NMmgxn23ynNkGVrt9gD0Z+6SYV0g=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=uT9CNvzM66Z3ndrbsOA3XrX1Fr5ihmPkYPlp9nvcS24o7EAUZGW1QjncpDgBLTRUVAekt+OJdL65BQww760jofUyTT1gRqgOhA96S4+0CyFaWCslkC+SOgOhMZdfkReP1xjakQGY4ndPTjot5rUFGiRd7sANESGRAzlCr4ThLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=I9mNZXHM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6467vYQi91844915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778054254; bh=rQcxqeddG8He+xQbSo60krSpUCCHxII/6odMeZ97RBU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=I9mNZXHMvwbS86sc+3o/szn/QTHEeBl2BXhPTnMZoIidTaZDs08nQwfiTi+QlTF0s
	 1xVzetdps4o0AYZoMCR1f83QjVj23C8ebB4JGVmPyj/Eb+LmGcopVnqOvR8BhSOHBN
	 C8RuUNVWmoaZMnSJVh1Ig0yEoUaDMRMaz82fLv7PrCm5xOuCqjwrpeRmVjOqdFjjkq
	 OdeYXMABPWwdXs4nUDP1uo3L9xSF/ABIzqCS9z5Zsj86MqSX6IbqQmPJE/IIvT/uhw
	 NXo3HijSMvJnfwxt0adBQkyvWhfbMDl59H140coCeunHvmZjKWcsVN+Gy/ieF2Uyzg
	 l+FskRS3WbQ1w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6467vYQi91844915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 15:57:34 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 15:57:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 15:57:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 15:57:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
        <art1310@proton.me>
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported channel width
In-Reply-To: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
References: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
Message-ID: <ee88b3a2-2cc9-4370-b782-189a603a7fa1@RTKEXHMBS04.realtek.com.tw>
Date: Wed, 6 May 2026 15:57:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 76D614D7821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35993-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,RTKEXHMBS04.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some devices malfunction when connected to a network with 40 MHz channel
> width, because they don't support that.
> 
> RTL8188FU, RTL8192FU, and RTL8710BU (RTL8188GU) have a way to signal
> this (and some other capabilities) to the driver. Get this information
> from the hardware and advertise 40 MHz support only when the hardware
> can handle it. We assume the other chips can always handle it.
> 
> RTL8710BU needs a different way to retrieve this information, which will
> be implemented some other time.
> 
> Fixes: dbf9b7bb0edf ("wifi: rtl8xxxu: Enable 40 MHz width by default")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221394
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ef771eabc79d wifi: rtl8xxxu: Detect the maximum supported channel width

---
https://github.com/pkshih/rtw.git


