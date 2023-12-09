Return-Path: <linux-wireless+bounces-592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA580B5E8
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F62B20B02
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0A154BF;
	Sat,  9 Dec 2023 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBdu+SYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352FE7
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 10:34:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d99c3a3a32so2108946a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 09 Dec 2023 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702146882; x=1702751682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4TtXN7fZl/QIrz1nYS8f6aPoGSRCqA2Q9OGYKaC1sg=;
        b=HBdu+SYJGqL5ImNCy84w3D7ezTWt8H6FG5f4odpu2xkltD8Dy6NB+fV6bxXZRPliDl
         GczIaKv/xVeGsD8oDAjBYgksOEQR94qzk0JQJcJq6TAM113qrBdT5tgLnHo9vDxadSJU
         MFmt14Yjf7CkZ7+4OtbgowGl+6Ln9kI0fzYf/gqM7htkvvkXm+PJ8UiFubbbMo4IW12T
         q54Da7XpaEKoDpYSs+Y5olr3EvRbpcTfBq884r3x9p/biJKKpmtahjeOg8YW3scBr7uw
         +M0VznV4GTMUPSCYEq2Lf3+3OXegXJzuABBoVyFHZNA+F6UNevobC++PyOfoPkVGeUVu
         hZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702146882; x=1702751682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4TtXN7fZl/QIrz1nYS8f6aPoGSRCqA2Q9OGYKaC1sg=;
        b=PIUlBq+De7nIps0k84TeuWhSfImojqwx0ZRmt5IY0JMKjEcV6SuaYh0p5DrywGRCBU
         AWdpthjEkUzAfpglLg2H7ihJunqNmgkkiMMGnUcScF7lKI84OoT909fGM8xHi3ECFHr/
         1Sl5TNHXY9zoEt8OrOvsszJsJ3lJ3kygwm1Z+n5wkPVqh/+GoPKsDzzXeHS2T4FsvFSg
         uee/7uyrpbA1xilfksqnkXykJNBmhNSZch8X4J1oF3HVv3XGN2uD/SuIWNT1EcIt0X7H
         mLeVYxfseOlrNeCbUDTxVMF2qPXacR/Cr6dpdRplO8fYn2wm1v9Q2BNiEFb4L+yyxZiU
         XBqA==
X-Gm-Message-State: AOJu0YwdMo3ML98t1TAlLBGeXqaCC+hci9KAp22Tjh8PvlcAl/ZckFBS
	kNXy03gRiaIjEgozDIUJHis=
X-Google-Smtp-Source: AGHT+IHNZoL/0S/Ye5rUfYM37v3MC4QoT1BQMKupPYd8/ZCL85hUuzwFYHo9u9v6gUvJKh1BRLZ3ig==
X-Received: by 2002:a9d:77ca:0:b0:6d9:d368:65f6 with SMTP id w10-20020a9d77ca000000b006d9d36865f6mr1851008otl.22.1702146882221;
        Sat, 09 Dec 2023 10:34:42 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id i29-20020a4a929d000000b0058a3c5d590bsm973202ooh.7.2023.12.09.10.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 10:34:41 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <60d366ff-8145-4f9d-a9f3-e27b82da31c2@lwfinger.net>
Date: Sat, 9 Dec 2023 12:34:40 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wireless P2P support for rtw88 families cards
Content-Language: en-US
To: marco.rodolfi@tuta.io, Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Pkshih <pkshih@realtek.com>
References: <NlE3B0K--3-9@tuta.io>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <NlE3B0K--3-9@tuta.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/23 08:52, marco.rodolfi@tuta.io wrote:
> I have seen in the past that this feature was already requested and Ping-Ke was trying to see what was needed to be implemented. I also have seen that this has been implemented in rtw89 family of drivers around one year ago.
> 
> Is there any progress on this feature?
> 

I added the tentative patch that Ping-Ke suggested to the rtw88 repo at 
https://github.com/lwfinger/rtw88.git. If you pull that repo, you will get the 
changes.

Larry


