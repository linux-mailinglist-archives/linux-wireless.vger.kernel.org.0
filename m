Return-Path: <linux-wireless+bounces-11898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D395E2F2
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 12:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206EF2822C7
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52B7E782;
	Sun, 25 Aug 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fd7pTfrx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A7179A3;
	Sun, 25 Aug 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581271; cv=none; b=a5sDDF/ywAsEUz3hbsEmmq8efk2QmfVhn5635iSOiKdVbYM4yEvxHdMq7uDpGAuB187lXVCSqiE7HolrArkNVUbMQXekoZX58HIZYHMy+2aI4EvTZezx/YWso8Xzqf4AFYAunxvx2nptLqmImucyG9EVewANq23crWniny9qhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581271; c=relaxed/simple;
	bh=UgnzpKPOXVRPoV4o3k9+mCHEc+u+lKjXZyWUCMUjM/c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rUcy4nLS439sBhoPs90ZZuIr+8Pjpc9LlQ0lHAbCo8FgPxcdKPliTOXo892FS9NXhNE4PiaWYEtnI42ePOeRRbFbYAwG2AnJh1bw00gfMXsEUC7gAh5bK39erg689j5uUkx80Sjmhd1a8uYsZBUWlso5Up8CjXjl/7A9MRK2yaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fd7pTfrx; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724580962; bh=JZNt9zJQ6CogOHVsBFz/Z7yNPW5r1uXeVyfB6MiRgz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fd7pTfrxQSFYenjkmFkIyyzjtP45o75kRH9d9G1wBcwLZqKPpr4TKmG7VwongcU6p
	 qg+meOQOQs7Nqvy0Frn3BIXVNkdXP6roVEoE7NCAndb7cPpS5P2ckteSy4cQe+P98a
	 446vhx1Si249I4hU7QXYJAkh2w8QSuzN0ZV5Cvzk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 26CA3666; Sun, 25 Aug 2024 18:09:44 +0800
X-QQ-mid: xmsmtpt1724580584t1u4fpqlw
Message-ID: <tencent_89BAE8BB0933D89E1D1BD94B891BBD257208@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaCzYfCGXnbxUaCPgQ8YecgBtTTjNOgQnPaaoFs0LTEL2XYq8N9b
	 wmgV0CpyISXsUk/o00WvueezscGsrAEEuy0IGhjNd79MF5tfjAMY4ZAk0D5A+kkgJAQt95O/TkGE
	 8BPgIlZOdtQN9gxX4u5T6l+9cC7ek1JoIjP078NkFIX+4a2uN67K+yrJg3pknXuhhJVRGtkVFjVN
	 oBSznZ8n4g5P50NlLrwNW62p1pjk0HBbqb2qYkOHWNd2muZx/gbkPS26tTxnnEoPi1vN7aqP62kO
	 EBDZHLupjEPqk+Zfp+UAD4fQjwo3u/lOOCGBR6UMyKT58rkCHxaMXXgbU6C6lLUjb8KW6Tfzhz6R
	 sBcFXH6Eb+IkrhpiEStVBofL5WH73/9WmtkuICaNOC9zSZc9XuGib3qVA1NZHsDGHe4k9KD0UCG2
	 LbWLTKv2R5y76ZF6h5d4hmiFJZW+c8EFB5AHSsUcxLW9EOm3IOpPcddl7X1QQ3JcMXyjeBG1DAeS
	 wwbzC6/BzV9yT6LjWiNPW5ic44ngw7OA09qiRjXIXRMWT3a+1sJR9EhEl6aNv8duEmCSIdd19WmI
	 +vcwsmzPuEMlHHgGRWsLEj1pXSgkRGw+rdlfYCZqObTuYZVyHBrnUwLGCie6qO6uBbFkKvP42Lm2
	 Z0p1PhIXtN8Ikvun6AbsOy22CYCmfgdrPRaHYOZw2AaVAmHnZOHVmmy9wLpYkFVm8LUXMKvtUB9D
	 4teFAP0qfazUiuVi2qPxPbuHofsxFV/yGtfpXsL1ESFCR0dPdytBCO09H1lHgnRuqah2BMeQ41HJ
	 67pFlfD2ZrdyIU2kBF8oTjQHnbcYmpqn4XKHhsKK8qU2uNSUpiT4FXlTFTTF26eM2L8a1VX2649A
	 h15xA/xG89ExfQekQCsDj9O4Y2JA/08upFhP2APvJ+LwpH+xXM3yzkIIO0ZiWLO6gn43+FFpUQDb
	 uXmCew1PSzePeAHERiy2DtzRxU6Me6fswHOeqdO97f25XfEgGWDw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Date: Sun, 25 Aug 2024 18:09:45 +0800
X-OQ-MSGID: <20240825100944.2343702-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082554-manatee-ashamed-12d5@gregkh>
References: <2024082554-manatee-ashamed-12d5@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Aug 2024 10:34:00 +0200, Greg KH wrote:
> On Sun, Aug 25, 2024 at 04:14:17PM +0800, Edward Adam Davis wrote:
> > On Sun, 25 Aug 2024 09:25:37 +0200, Greg KH wrote:
> > > > If the data length returned by the device is 0, the read operation
> > > > should be considered a failure.
> > > >
> > > > Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > >  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > index 5220809841a6..2a89bab81b24 100644
> > > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> > > >  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
> > > >  			   ret);
> > > >  		return ret;
> > > > +	} else {
> > > > +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> > > > +		return -EIO;
> > >
> > > Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
> > > that the actual amount of data was read that was asked for.  If a short
> > > read happens (or a long one), then an error needs to propagate out, not
> > > just 0.  See the "note:" line in that function for what needs to be
> > > properly checked.
> > >
> > > hope this helps,
> > Thanks for your analysis.
> > I have carefully read your analysis and I am not sure if the following
> > understanding is appropriate:
> > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > index 2a89bab81b24..35884316a8c8 100644
> > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > @@ -932,6 +932,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
> >
> >         kfree(buf);
> 
> First off, this should be using usb_control_msg_send() instead of having
> to roll their own buffer handling, right?
I couldn't figure it out with what you said. 

ath6kl_usb_submit_ctrl_in() is similar to usb_control_msg_send(),
both calling usb_control_msg() to communicate with USB devices.

In the current issue, when executing an ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP
read request, the length of the data returned from the device is 0, which
is different from the expected length of the data to be read, resulting in
a warning.

ath6kl_usb_submit_ctrl_in()--->
	usb_control_msg()--->
		usb_internal_control_msg()

usb_internal_control_msg() will return the length of the data returned from
the device, usb_control_msg() return the length too, so in ath6kl_usb_submit_ctrl_in(),
we can filter out incorrect data lengths by judging the value of ret, such
as ret != Size situation.
> 
> > +       /* There are two types of read failure situations that need to be captured:
> > +        * 1. short read: ret < size && ret >= 0
> > +        * 2. long read: ret > size
> > +        * */
> > +       if (req == ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP && ret != size) {
> > +               ath6kl_warn("Actual read the data length is: %d, but input size is %d\n", ret, size);
> > +               return -EIO;
> > +       }
> 
> If you switch to usb_control_msg_send() this logic gets a lot simpler.
> Perhaps do that instead?
> 
> If not, then you need to check for "short writes" or zero writes, see
> the documentation for usb_control_msg() for what it returns.  Your
> comment is not correct here, there are 3 different return "states" that
> you need to handle.
> 
> And why are you caring about what the req type is?

BR,
Edward


