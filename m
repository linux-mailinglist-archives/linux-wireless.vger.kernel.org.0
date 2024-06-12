Return-Path: <linux-wireless+bounces-8861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A11905244
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9986DB20FDA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851816E896;
	Wed, 12 Jun 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W4is4uPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nol957Zv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53F374D3
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194836; cv=none; b=gYT/dFTCC80u8ztelwOUzV0hxXoMXCtdw8tNd3g3MJulC1T/x4mqsApbCKBbaufz8B77QB7wISaETo+zycrzmj0i7vb2LhUJp7g+/cTCksWSZCpwfIvKv+9NDsFtgkLl7tEIqIFk/fqsaqJWSZPBfvMzDp5X4I8RqoaLslAeQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194836; c=relaxed/simple;
	bh=0M4WDkNUH4uni+1hP9fzTtfzig7Abw5pL+p6qm/QFoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXzcB8sJY1K/xf1eIVYaIDJcYhUMS51QIs2ovuMMpMq7fA/vAbO95cxYHrgTP8lq1cElT82WzOVGJk8pnYlxK3IwsLk1KoRBUkA3N1NUtIRJE8rzvnBbVWLk42psrYNiT3iyGxn9IYb4xCqUlf9MqnYS0VVrWirGoH3RgqQfksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W4is4uPe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nol957Zv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <8581983e-714b-4173-9150-061f57516ab8@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718194833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuNKtumjew5UirDIKR6z2jTulPfrROzSJT3xO8kDV90=;
	b=W4is4uPelp2ecSSKROQLXlCEG4UgyhaoOeyzKjn+x/Oz4GtuD9S4rFk+Zty790ghvDIw7D
	gzYvhORzPb0wX8dS3+GgGB7h3Fa1dFIopHOSEIsipQosQ14XPmZ6mbuLJLx8/46ygxHNQK
	jap7EF2QP7W2SUqtkQoaqMYQFqQhTdb2REKhDZLb2/pG7+Gvd7zOUM4rZTSPIAPPT7auxY
	MqYYcEcJlP2SCv4z9W99sNuf88UEg2+aGmh8griNAUrvjHyi6OTZ+sp8NK6Hs9p1Yh+mCs
	7R1e/7Z+uGrnEyPIwoZkrgVKBMQlmX/GXQHMMc9i1jE3eXoyxCmIHj23dAO5ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718194833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuNKtumjew5UirDIKR6z2jTulPfrROzSJT3xO8kDV90=;
	b=nol957ZvuIMFgqVY5/DDMYDguyzHknDn0SjUzm2oPXY3pNFEEg5Ca3sTVC56MYuYv/CAXs
	pa8y/m8emixt2dCw==
Date: Wed, 12 Jun 2024 14:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ETIMEDOUT with rtl8xxxu
To: Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
 <1385519564244924a1101770344544a0@realtek.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <1385519564244924a1101770344544a0@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 12.06.24 um 03:47 schrieb Ping-Ke Shih:
> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
>> Hi Ping-Ke, hi Bitterblue,
>>
>> I have a problem with the rtl8xxxu driver and 8188f, but only on some boards.
>> More specifically, I can see that during the second channel switch (which
>> happens when I do "iw dev wlan0 scan"),  the rtl8xxxu_read32(0e08) returns -110
>> (ETIMEDOUT) and after that no reads or writes work anymore until I unload and
>> reload the driver.
> 
> If this symptom is 100% reproducible, I would add many rtl8xxxu_read32(0xe08)
> somewhere to bisect the cause resulting from writing IO or certain H2C commands.

Thanks to your suggestion, I found out that
1) the timeouts start occuring right after the first frame is sent (rtl8xxxu_tx)
2) the adress doesn't matter, rtl8xxxu_read8(0x100) also gets a timeout

I am now looking into the differences between vendor driver and rtl8xxxu for 
sending frames.

> 
> Example 1:
> 
> 	rtl8xxxu_write32(0x1234)	// original code
> 	rtl8xxxu_read32(0xe08)		// add this to see if problem encounters?
> 
> Example 2:
> 	rtl8xxxu_gen2_h2c_cmd()		// original code
> 	mdelay(50)					// add some delay to wait firmware complete the work
> 	rtl8xxxu_read32(0xe08)		// add this to see if problem encounters?
> 
> The address of 0xe08 is not always on, so you should read it after power-on.
> 
> 
> 
> 


