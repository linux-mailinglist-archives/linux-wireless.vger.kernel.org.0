Return-Path: <linux-wireless+bounces-11901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B295E3C0
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BB72819FA
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE314A639;
	Sun, 25 Aug 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rIyuXQMF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6422BB1C;
	Sun, 25 Aug 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724594946; cv=none; b=j4RBCTFN65lNqBfhtYPdPm4fROAuVXzs+mqO4sgR92euQqBgit9L9GBD1SqrbDVd4Kd6KAu0f1R77dikIj3y+DOKmN5R9JMkMNZVBKDu71nix4pQnFwrilSnCNIhawBcT6lqfKI/xY/6OnWl9IFwMCqeTPx65rLLh1paecQdQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724594946; c=relaxed/simple;
	bh=1vMTfkV3u3f8XzrlV2oCUiPnfvE+KGzhYdx9HGVM5OM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DYNllAB3VkbBdhEITlBcdA2iDtFB6Yb4QulknPSuLR4huaRLoSbxdfIHjnC64oCVf3iGNGFV2bX2WVfsofsoz6GBMEjDUG+ruJ/eZD1IzpYNRq0sS2qaU7qWK9UhUp7Ik02CHgVogExd3tivs2dlt2I7L4Vx7RGEdWcLlnBseSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rIyuXQMF; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724594633; bh=bHonpRwI/VKAepoYUCYAp7Tybv88sHViLVAqA20dF+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rIyuXQMFhHt5Z8cgu8032BnsjzIENFvfTj4fTszFGYVbgxM3DVgNH5fZQILQ8ffvi
	 pla7kgQBNR68DtwbY7mmQvkkKGXWhQNoWzIJ7OgNuQG1KhhAZCjH5n44hv9Dq/Crjq
	 3mtRsusTqQyEehMoXPLU8wNCL8t6Ou79jm1siXv8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id F1A0814; Sun, 25 Aug 2024 22:03:49 +0800
X-QQ-mid: xmsmtpt1724594629ts0dbh151
Message-ID: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
X-QQ-XMAILINFO: NWOHIAASQnT+Q6isGvpmjAvtrBYB5rImQ2kljw761wrKgw9UHYGPmxIWk2Rail
	 ALWs7lUvswpqXB8YgN5fQSULuLqXFnCli4F8vllM95kCfrlWNUv55cv6Rf20Kr8gorMMTAwlK7Qt
	 VZGLBTSgY2WV7RW0JrhrXp/1zDALGITTiDOAF1BV0vhVikGE3jjp+he5YhhdV3ydOII3vR0U2gez
	 +PhUc2kq2rINlLH+dh3KN4NeITIlvbkx7qKFXN+BKg2EaKE4IJVRoJCvxYvaoGkIfLebmXj+aoiE
	 nLVuAGqVlK+S+b24G/i+VypXP4Vtgoh3mSOkn7sx9YpA6mcfwpLszdynfkICCn93r614uw2JINVs
	 gKrXqn8d8obasoLA3N2R2tTjmBjuUUTnf6Bghn8rbtQHIGYU/CeaABTeYXVqyauKElCjUSR1CO//
	 h9MniNyCp36lKIB9flSQ5QdGiZ9f1Kw/amIVXdVTdNsb5AdOZnjXeshQ5OoOJr7WE3SCfCcPM0yB
	 4khx1faZmKO03l0TiF+7dKZ/8XShSPZsqdCLeRQUIJdyYl3eIXD0JVs4ZWf05/m+EI7ykFDP6apb
	 OmitQgx+4JZb9sXjdOQIJj+JS/nov0pYD5pOLpT90sgZPCbzXXx50qf7wk/copgvgxHDo9UmXPWG
	 FOeCLdByTSnVoO0Z6iOrYyfjzb4FAQ9lxoaemJIYnToT0H1uWjMVBP+WgOE8Fa8Htgkk6W9JRc6l
	 ptOm/hMZjGK21xHICNQ9FFz7CpU8V1ZPUMZVxZpuDTzhZxdhpqvqD7HNXYq/zDaNOl3d54cDezmM
	 9SNjhIlrumVYbIKnOCVW5c/UHZflOMX6M9esiZZ+uWMtUpqrThp2KTEDc0PNtjrNH+UqQVw8L7+S
	 2HrAR2gujhMTLNdJOrcn4O9jpx8tXQlgIo9gVtDF1vlySo3pXnr8sA+sjW7vlqTq08bHMHAIIawr
	 CnI6an32hGQ8gsIXmTfgneJ7IR2stuPegt/SBnrwijHuTZ/n7ubSycwnr1Ua+XVKuZRR32D5Cm2j
	 jJFmAJHQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Date: Sun, 25 Aug 2024 22:03:50 +0800
X-OQ-MSGID: <20240825140349.2547232-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082501-tiling-prelaw-38d7@gregkh>
References: <2024082501-tiling-prelaw-38d7@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Aug 2024 13:25:56 +0200, Greg KH wrote:
> On Sun, Aug 25, 2024 at 06:09:45PM +0800, Edward Adam Davis wrote:
> > On Sun, 25 Aug 2024 10:34:00 +0200, Greg KH wrote:
> > > On Sun, Aug 25, 2024 at 04:14:17PM +0800, Edward Adam Davis wrote:
> > > > On Sun, 25 Aug 2024 09:25:37 +0200, Greg KH wrote:
> > > > > > If the data length returned by the device is 0, the read operation
> > > > > > should be considered a failure.
> > > > > >
> > > > > > Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > > ---
> > > > > >  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > > index 5220809841a6..2a89bab81b24 100644
> > > > > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > > @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> > > > > >  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
> > > > > >  			   ret);
> > > > > >  		return ret;
> > > > > > +	} else {
> > > > > > +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> > > > > > +		return -EIO;
> > > > >
> > > > > Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
> > > > > that the actual amount of data was read that was asked for.  If a short
> > > > > read happens (or a long one), then an error needs to propagate out, not
> > > > > just 0.  See the "note:" line in that function for what needs to be
> > > > > properly checked.
> > > > >
> > > > > hope this helps,
> > > > Thanks for your analysis.
> > > > I have carefully read your analysis and I am not sure if the following
> > > > understanding is appropriate:
> > > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > index 2a89bab81b24..35884316a8c8 100644
> > > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > @@ -932,6 +932,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
> > > >
> > > >         kfree(buf);
> > > 
> > > First off, this should be using usb_control_msg_send() instead of having
> > > to roll their own buffer handling, right?
> > I couldn't figure it out with what you said. 
> 
> Meaning this kfree() should not be needed if you use
> usb_control_msg_send() (nor the allocation above it.)
> 
> > ath6kl_usb_submit_ctrl_in() is similar to usb_control_msg_send(),
> > both calling usb_control_msg() to communicate with USB devices.
> 
> Yes, it's close, but not quite the same.
> 
> > In the current issue, when executing an ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP
> > read request, the length of the data returned from the device is 0, which
> > is different from the expected length of the data to be read, resulting in
> > a warning.
> > 
> > ath6kl_usb_submit_ctrl_in()--->
> > 	usb_control_msg()--->
> > 		usb_internal_control_msg()
> > 
> > usb_internal_control_msg() will return the length of the data returned from
> > the device, usb_control_msg() return the length too, so in ath6kl_usb_submit_ctrl_in(),
> > we can filter out incorrect data lengths by judging the value of ret, such
> > as ret != Size situation.
> 
> Then just do that type of check for that type of read request in the
> code that does that call, not 2-3 layers deeper, no need for making this
> more complex than needed.
> 
> Try removing both of these functions and just call usb functions
> directly.
I have tried following fix:
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..dc1f89ebb740 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1027,9 +1027,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
        int ret;
 
        /* get response */
-       ret = ath6kl_usb_submit_ctrl_in(ar_usb,
-                                       ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
-                                       0, 0, buf, len);
+       ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
+                                USB_DIR_IN | USB_TYPE_VENDOR |
+                                USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);
        if (ret) {
                ath6kl_err("Unable to read the bmi data from the device: %d\n",
                           ret);

I researched usb_control_msg_recv(), It handles the abnormal length of the
returned data, so using it directly can fix this warning.

BR,
Edward


