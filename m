Return-Path: <linux-wireless+bounces-11978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB3D95EF81
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2B1C21D26
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9314D457;
	Mon, 26 Aug 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="etz/aUWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E713DDD9;
	Mon, 26 Aug 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670790; cv=none; b=qC/pt3UTStBDGxXsoil2YISBeuZGNI0kuzRgjXScX7QCT5g3yzmmxGTS+DWd0qj6Rnu2ThEigbmUYK1d4d5KXMeRG4ikPJGWbKAbI7IjUuyoHt7F1yH1tdGxzu70ELm0TdLaz1pvWVhXhlahs7+9aoilu/uWCHlXSOrWtSM4FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670790; c=relaxed/simple;
	bh=02cFjT9rCSquVRGY5ROZxzrKmwM9NghL3+cjh0Ae9ys=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Kh7QpegXtKcnixU+8y4pu/HlLMoJxUTxy0JaYdNroMwB1YcOvVD5mp+IlyxnpCq4VMG/yHacfk8vuTDboAHSU2deJaAIX5U4WP4rYlRdRfiBjlGEJRbDNoRw7v3d3QlogZcy+nbO2TpAMV5rguQNADoaThDJS3qUfPK6/TGzEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=etz/aUWJ; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724670779; bh=lUpulHGMOGngdtU0gm+4Ln7iEb36uBYkJQf78s2pWtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etz/aUWJDNcih8LdHVLqGPS7DVB5cQBmL2bPu10BDXMiwVamL5Z42bO8c/ivbltGv
	 Ltdu8JVck3o5HCl13VwwXRQIBPxgKiAjRkbFpcA6JIU9vbbia97aL4wz6HhL/85gpI
	 2wrCbcCYX0gIh6iMgvMyjF3TL+nY17GTEi0luNrQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 3373ACF7; Mon, 26 Aug 2024 19:12:55 +0800
X-QQ-mid: xmsmtpt1724670775tf2wz6iic
Message-ID: <tencent_2C2C336C9E441B294BB21B6A2558BA34BB08@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DM8ghTm7BKAMcP/rKH+fHPKtzuBJVGkSe4iTEchhTRkAJuHI6REV
	 W26t0cY7S1wwplTCQznYfbudqI4jj7gJ6Dn3+vzelMSffkXO1E5jDjdXPkFpt12EHXkVX/YNdpA+
	 +FOs65YRPNVp++v7Lju48A7PKaq34+6bLRjQWNP7quCN0btYd/Bx1atupZjEplzNCDrEpeDRyXfK
	 6HjXicbcCAz3OvtRkm69DdCGu72yt8hevXWHHWiuZnTW6YP6Q6jT2ngfW6R3/+omvHDJtRnNRwUm
	 0BBdvtEvCRhKDqo09BgdFaMWTYDoSS/ebwm/LMGMsrLrELFH7lebVFkElalfgQsZUXOBOE8ZkoMV
	 leP3pUB7grXugYAVkax+6F9HMD6TNvU/A2C8K6QszhDE6KLUIvJcsavueDWBRJARxdXE0c6bc/8h
	 OWtx+LVaY8D+kFMssBuGdic+hRblbCpOZFEvqRh7Q9Qa4krgAkpuv3WR4DTimpAi+Dx3dd9WRRt4
	 z7WXdl3qQi77KTliovUl5ma1EJMxQoHFIimuwByAhXrJInFKLKZ2R4Wtp/iuNSHwM90DgMMGkshH
	 PC12B+gBllEJ14h1KK/RntI5YxXmBC20jcbBdRHKkqiZqfNn5s3h33eSIftTgGsNTfRX11PwKnRK
	 UByX6/7+XozbU1D7YO9Q15WT4rWzi5mTavwryiLFuZsN3o7W756YrmcMy/j8Rdi8Bufzf2guVUpF
	 WN2ohoQwZFHMFViG0dJyFZlC9OfzzMdZzC6pM1XJd1z/EvBpUUcp6rwlElWUF7P6XatxzHVmBjGE
	 8Hmo76IygIatdVKTsIWohPyItl+xeCk4F1EOyKvO8DZlA9YMmObXwN6O7mkyayyLJFL5lzNI6UqW
	 HGwxm0GXyqTY+VbAmsFbeYRcQGiVfbkfraPEEcSawdDsZDniE7EHDVYQalWFGzuS51D7Yu+rNUvV
	 rwmviHLMug9Jx4XCGrLw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: sergei.shtylyov@gmail.com,
	eadavis@qq.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Mon, 26 Aug 2024 19:12:54 +0800
X-OQ-MSGID: <20240826111253.2606362-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082649-shape-karate-40b0@gregkh>
References: <2024082649-shape-karate-40b0@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg KH and Sergey,

On Mon, 26 Aug 2024 07:04:00 +0200, Greg KH wrote:
> > ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> > the length of the data read from the device is not equal to the len, and
> > such missing judgments will result in subsequent code using incorrect data.
> >
> > usb_control_msg_recv() handles the abnormal length of the returned data,
> > so using it directly can fix this warning.
> >
> > Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > V2: Directly using USB functions
> >
> >  drivers/net/wireless/ath/ath6kl/usb.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > index 5220809841a6..dc1f89ebb740 100644
> > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > @@ -1027,9 +1027,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> >  	int ret;
> >
> >  	/* get response */
> > -	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
> > -					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> > -					0, 0, buf, len);
> 
> By removing this call, there is now only one call left to
> ath6kl_usb_submit_ctrl_in(), so that probably can also be unwrapped in a
> second patch in this series, right?
Sorry, I didn't clarify what you said.
> 
> > +	ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> > +				 USB_DIR_IN | USB_TYPE_VENDOR |
> > +				 USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);
> 
> As was pointed out, this is a very odd indentation style.
I will send V3 patch to adjust the indentation style.

BR,
Edward


