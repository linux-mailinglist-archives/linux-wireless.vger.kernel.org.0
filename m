Return-Path: <linux-wireless+bounces-11044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C894979C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0621C21A96
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAE76035;
	Tue,  6 Aug 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qzUBASle"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F16F2E6
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969412; cv=none; b=b7kVurENz2bzqd0ObLy/pxma5a8SWTgFurngYxV4I0vMYPRUekOIVtCm9D1N+bVMeHMa3gmGrcBLHFBrh+wiUjWmFUZW/2kxYXyX0tlDpJTq1XsEHghrOUpE/g+GS/j3sfJ/v/+JfFsgy4hVjejIyThD6h6CtCgjwgq05oqX2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969412; c=relaxed/simple;
	bh=lD1CXg8ewgeFDdS9UW1qlnYh29XhmwAyYiYoddDl1pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg3VrPyq1latqD2qpUXeQvtWJ3nminjEuELxx5AEl/kWjICH/sYbAkRfzB3AwBn2ko/tqUxMCKK1G0YRYEkMcpp4lu9iY0FmR8eljNtYq+4mC1FLR1C1rQuQi70jl+r6dm3DR7iX4AQtKJ/r1qf9FElnQcXDMqaTpdAnnCroL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qzUBASle; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70b3b62025dso545750a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1722969410; x=1723574210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmTu6CdLhKUuviA48G6Tr36ATMsK0k+PUHlqmhgRePo=;
        b=qzUBASleLVMeuDgJdBnHQSKRSdof+rpyEn4HitKx6cemRHfIUxFUoZQB3Uc/siFsiu
         I1+H8CIEqueYd10anqrTJU1Wclg2Q9lsP5noZC7+DI1oX7aA/Yeo8pRBauEeTsCPaDFX
         caVDDXbe97jFztqft2ndoeAKfd+llmkeZ62AJlJ0Qu3ZOzrb+8Rdpq+yO7mn4TEpoFPw
         USRt+BrxyEat72fyJUafnJSFux+2Plt4mH0yJiWlOOzR0/AIQU4sN2ikZLFN8eBjnRp7
         yMm3tJXucXmKwMhcKTyitnniwphBGCYkAa2o2V1mQQU5ABuaoG/r2oHVjQFLCyGtwZ/2
         mGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969410; x=1723574210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmTu6CdLhKUuviA48G6Tr36ATMsK0k+PUHlqmhgRePo=;
        b=etyrVSbDd8bs3DgaeFKN1hpj8PqW4JCHZJ1sV/u2EW0tLI0K5EFX8EaZlB2B4DGlja
         KWkIrV5tMr7gbsYEwXi3QVP3Wxx2MI59x2kQohAR1HgqJFkg6vuxvFu2ozfO1qyKOayj
         q93J7U3N1KFlie+EDW8XPi131PqtZIhuuUTAa2ryJCQM9kyei3+1oXttd+Nulx+wqjRx
         ZJR0g0+3o8QLmTFLYRSZSiRucmq0uHBwlC8nPMwJoldl1KJB2qVBJ1BR+bn0wYp8O526
         tEUptgZYcN6Lth76Y6UDxTn+8ouFMvEcsiP70rVQ40mIi4dt73Rhx+oXOF9ysc4ilClR
         qhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq3ac4/Rtx/sR3NqJRM+PgOAUH6dvYKqiK1YP2/jcFMlvo8tHyuc2ARgyp/I/nxOW30sJd643XhV2sevhK5SoHxcci8SrawuYAbtr22Ss=
X-Gm-Message-State: AOJu0YzmKAyEABDuYnRsZPjsOANh5Y+HhTgKeHmFhDoCcP5ji7IuIzfO
	KYnGCpsLeXjpR4At2JmzMJF5IdDzceuyIBpSzZfwoFpKDeCIHLhV2nEITM4Xrg==
X-Google-Smtp-Source: AGHT+IEnkJ7Z2uIaGOQDKmaJUB8KkdOaHVtwQNHPo7SWgBve6YLjfN5VB16mdbxnI9tcxLO7BTyxxA==
X-Received: by 2002:a05:6830:4882:b0:703:7842:6c00 with SMTP id 46e09a7af769-709b323a22amr19236323a34.15.1722969410083;
        Tue, 06 Aug 2024 11:36:50 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a76f863sm40057131cf.82.2024.08.06.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:36:49 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:36:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: color Ice <wirelessdonghack@gmail.com>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, mark.esler@canonical.com,
	stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <ffc826fe-4753-4e7b-92aa-080f58b73c39@rowland.harvard.edu>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240806015904.1004435-1-wirelessdonghack@gmail.com>
 <bc57c8b3-4334-4595-8b5a-5233316edcfb@rowland.harvard.edu>
 <CAOV16XF8cEg7+HAFQiCUrt9-Dp4M+-TANjQqRXH87AAdgzmNMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOV16XF8cEg7+HAFQiCUrt9-Dp4M+-TANjQqRXH87AAdgzmNMg@mail.gmail.com>

On Wed, Aug 07, 2024 at 12:47:26AM +0800, color Ice wrote:
> Hi,
> 
> I'm glad that you can address this issue. I believe that this is indeed a
> vulnerability because the issue is caused by the rt2x00 driver's failure to
> properly shut down its async queues. While it requires sudo to execute, it
> is still a problem as it can trigger a kernel system exception. We can
> imagine that this vulnerability could be executed without root permissions
> in certain scenarios. For instance, in many embedded systems, configuring
> udev rules might be necessary to ensure automated operations, and in such
> scenarios, it can be triggered without root permissions.
> 
> Therefore, I believe that from a vulnerability perspective, it should
> indeed be eligible for a CVE, as it can be fixed and it is indeed a flaw.
> If this vulnerability is not addressed, future driver processing and
> adaptation may encounter robustness and security issues. I believe security
> issues should be handled with the corresponding seriousness.
> 
> Thank you.

You didn't answer my question.  Are you able to test patches?

Alan Stern

