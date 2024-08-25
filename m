Return-Path: <linux-wireless+bounces-11896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EAA95E2AB
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C9B282030
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33A61FFC;
	Sun, 25 Aug 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J51wO6Gf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F67364AE;
	Sun, 25 Aug 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574475; cv=none; b=Z3pD6uTYAoQKLz1yF4fo63Og56O8A84ewDiMIrs9b/+gIcSF1Z/UrR9XRJSo7madVQI/mtYpNmDpTKxxUkL7iUWGcBJosu5rNHHVQ746IgyLi7O1LrKwTLIP38/E3fOQh0KM1UwozkEJBifkE8O1Xi1EpQiwzfE3y4yELCAyYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574475; c=relaxed/simple;
	bh=EzfTqwP5++54n0emJ1pPOQ13RC+y/TmNzsNT7yCk4w8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Fbq+/ZzuECtYoimEeM1URPduRFAAirLJjpI1FTXIF0+ME/XvVSkxSysJFf75lWhSP90jaM/7GELYKrtDBLia68GUbm9ajC+C8Wg5w5xqypuElrVpC4bN0VyYia/HPyDaMlq4woNd1LYKNyDrMHaULwMHj1uNLhQzYOf3M7xgc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J51wO6Gf; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724574467; bh=K9JDy1HTUTK/42il7BrDFNhHYqZjLglr18rgG3OYqpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J51wO6GfOlfNi+SMz/EkMgPANGOY5jYCCAuRP/eI3uJZXQ8ujKVRxN2TxgpJ/amQG
	 lFMwgUdAOQ65adkY42+ql2tfQKpwuG9v4vLylRahlM8ndTFrnPHgtOiu+TyM3pTIUo
	 Evo/lRboPZekN7uvxjIXNJPRJYyiesNi2aqOTeHI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3913681C; Sun, 25 Aug 2024 16:14:17 +0800
X-QQ-mid: xmsmtpt1724573657tk9vp3f2y
Message-ID: <tencent_F3E6370A4B6C7467779367AE3CB3363E9609@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHUBSR0h8MKSzOutAdv4xELzxcoToh2vQs2nEQx+Z/dqlYhLW7y
	 0K0Q3YA1Z4aq6Ij1E5NdvdYiNT2pGXcMNRLbLkzgGIEnCY1rx69xZsWbPZTlFvIWZpa6jfj6x0Lb
	 T9AWamZ8ayhfd62BkCKeWdLqwC/iKRVsfEYHL1QL3N0v8md+Z5A3N7QMa6Px7NlmVa3+wAjSj5Is
	 ZtsbJvH4J7icQotwafAyVHgjJV3IHf2ka0+pPsIgC/nuz7qKUEefBuLk2mKO0LF90TU41qV09ZI0
	 iP9D4Fj+uigCpyFDdW7z0HjeCgG3MvvyJFvY7mms6ttgBHuZMLcajDHeK9CY43WvY5+BvciwJePm
	 WOHreJj6DuVjF6PZ34B5HC8Iwa1SvnxabfTqnM168rYdjZScHvE82Dxeg7sRVkAEOtOK8dBGYZQ9
	 L9VO5RKwYq93rfHnF8xw9do3lXnhf9Aaa85JNjioMMb90FiwqLHOwLFRXAdtlVahtUWjLc9g2SS8
	 UI3a6LHNgXDDdQwZSVRSWgFr+FFBFkVjbyaHEYV1xsY+AflgLibPnR5NevCAXgKu2bTdVIliA5J7
	 fTSizQiO1/j+/v6dnBHri09UY5UpA/zfIat2vj0v5vN56fLEv/GscMnuPFpx16/efVT7jmw8TfK4
	 hZvjeJjZasxULv8SFAYXqzZGYu/rrQ0l5WiCCG17Qyk8TgdC0N9p5Q+R5mUw0MgNWNyLeMOIiqD9
	 u9cYdm9DIMKchIM6x2b7p4YvEf/dqTj0ToDvjoZHfT4nWEPDvzs8j5N1ytOBrV3D9zRXsZQxnCoJ
	 sL/p97pR9YvtKmp+g8uQJSSAwCDurFwfVzPHyJignA/4VkfIvWoXmE6Ud6Kaj6E2NZm28jTq7x5X
	 McOb4WNrFmYKuzyv0Wnu9NTplRMe09fDpHxx6C0HXcdngfVKarhL2nuMwPCncO0PIo6/9xPgyK8a
	 jp6BlzYrmVKGej1qXJHwcUfkGBpZHg
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: ath6kl: Check that the read operation returns a data length of 0
Date: Sun, 25 Aug 2024 16:14:17 +0800
X-OQ-MSGID: <20240825081416.2242421-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082507-clay-riveting-16f3@gregkh>
References: <2024082507-clay-riveting-16f3@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Aug 2024 09:25:37 +0200, Greg KH wrote:
> > If the data length returned by the device is 0, the read operation
> > should be considered a failure.
> >
> > Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > index 5220809841a6..2a89bab81b24 100644
> > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> >  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
> >  			   ret);
> >  		return ret;
> > +	} else {
> > +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> > +		return -EIO;
> 
> Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
> that the actual amount of data was read that was asked for.  If a short
> read happens (or a long one), then an error needs to propagate out, not
> just 0.  See the "note:" line in that function for what needs to be
> properly checked.
> 
> hope this helps,
Thanks for your analysis.
I have carefully read your analysis and I am not sure if the following
understanding is appropriate:
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 2a89bab81b24..35884316a8c8 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -932,6 +932,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,

        kfree(buf);

+       /* There are two types of read failure situations that need to be captured:
+        * 1. short read: ret < size && ret >= 0
+        * 2. long read: ret > size
+        * */
+       if (req == ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP && ret != size) {
+               ath6kl_warn("Actual read the data length is: %d, but input size is %d\n", ret, size);
+               return -EIO;
+       }
+
        return 0;
 }

BR,
Edward


