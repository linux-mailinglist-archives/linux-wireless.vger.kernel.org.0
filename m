Return-Path: <linux-wireless+bounces-2300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D227835856
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 23:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D31C209FB
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D0383B5;
	Sun, 21 Jan 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK4s9Lz4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68821393
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705877466; cv=none; b=rR+hYic9/BF0h3A15NxZGMJIldzsYVRXfr07le7GLElDMcejHZeur6vhvkCXp22WFiPKJ/zTQv8ug0I44Wtjit0dRDHLG12lQJzYys05Ia0Xf0oMJ/+hzbLE6VS2wT4ACS2Xcv97S2aUfIm+CwPIe1D9wKgzTDdvF8W2qfIvMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705877466; c=relaxed/simple;
	bh=KL17O4lt4w47cmwoBSa1G//2NuM6Sa7xsYq+0s1LX9k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fkd3NN06QreV/b0ZRMOUTnmOS97R8cvQmoB8dlGL0nyTZp49gJ1cUoYOXTRglUyTzuFG5M6ve8n/2g7rGOs9vkQC+0p9Q1bfuevLvIObSQLI6oBEME79Ic+mQlhZR8wPkkzAbi+wCZp0iZ4ooh2yEMZuLVKwfLmZqH6U0j3J5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK4s9Lz4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bda6c92ce7so1657933b6e.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705877464; x=1706482264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2U+oPs+86/yfG2aRoL7CkaG2CC27TknMs/tvoJnvBw=;
        b=iK4s9Lz4GCO6qGj/l1EDxCeW+qBQSx9m9siITtv0xGyyB4R0fMVF+1yja0QEcvSpTG
         tDb7jM8NEfaoeW2KRGGTlOSke9Pt72lBGlKb30STae7ptwGwR0ZPewBxNHyUFeOg+gvE
         /YxbS3ymBa0mgeFUsI1tu33yMyB1RZAMR4g2brZql4aLb2Pxma0ugfV8UfwB7UMmoYA3
         lYAqz5sKRN3IiYnvMwcX5FrSUd7yaHKBiad3Gp0M35TyiCncfyDVseoZeDySFCN7Wab+
         1rw0330YflMKqsMA/fA4v14AMqvhlP1p1FxIJh16OZAzxrDZtUtCXtY2ENhxKaJWsK5v
         7YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705877464; x=1706482264;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P2U+oPs+86/yfG2aRoL7CkaG2CC27TknMs/tvoJnvBw=;
        b=RafU9duQI5is06g5k7/7kthsE5SnoWBb/642BdO2IX6pI3CfSACDu4516kOq76LOVj
         Omxw/clDXxZu4p/8UlCoBSHuqJ9l9q23OCCIqUqt9mZu/APmQjQaN2Y2YeNkZKnJYta1
         w61xgcEErTtSAbuVFoLHKxIIH9DVXA7xE7cMzTUZRokBwavMmiKVWNiSy2OfPdtKp94f
         5w4jaUcdzlaMltj00ySSZ5gwsu6k4G4bw9Hmx2p3608jCF37OYNzprKSiUlNyeqfwNiU
         l27Fp/Na/UHmMU5XLgfCtdr7Cw/qGaxSDwO8qYP9OC9uF6dCArhtuMn5lVGY1pJndo3E
         DQ3g==
X-Gm-Message-State: AOJu0Yyx8HiutUSuHGBZi5WAlH51QCTBAIZ4et2P4XsGcoMvmRy2nKU6
	2EIRhFrOmaxBltsl6DipBsRHoAWexNo4vs25MPJkt7ELjRXX7/UW
X-Google-Smtp-Source: AGHT+IHpZnWaAPlLKJXW0o/VhVsMltHG7P27e4JICGFPOcVix+zz3oBTtpYJtDHBASzGmhKeN5EiOA==
X-Received: by 2002:a05:6808:4495:b0:3bd:974f:5c64 with SMTP id eq21-20020a056808449500b003bd974f5c64mr5247654oib.45.1705877464259;
        Sun, 21 Jan 2024 14:51:04 -0800 (PST)
Received: from ?IPV6:2804:1b3:9403:d83e:b794:f318:e42b:4815? ([2804:1b3:9403:d83e:b794:f318:e42b:4815])
        by smtp.gmail.com with ESMTPSA id sh11-20020a17090b524b00b0028cdbf2281dsm8173031pjb.48.2024.01.21.14.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 14:51:03 -0800 (PST)
Message-ID: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Date: Sun, 21 Jan 2024 19:50:53 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2024 - Project ideas page for the Linux
 Foundation online
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 "Luis R. Rodriguez" <mcgrof@gmail.com>,
 linux-wireless <linux-wireless@vger.kernel.org>, dl9pf@gmx.de,
 =?UTF-8?Q?Jan-Simon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
 Daniel Baluta <daniel.baluta@gmail.com>, Vadim Mutilin <mutilin@ispras.ru>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Ira McDonald <blueroofmusic@gmail.com>, Michael Sweet <msweet@msweet.org>,
 Tobias Hoffmann <smilingthax@googlemail.com>, Jay Berkenbilt <ejb@ql.org>,
 Nicholas Mc Guire <der.herr@hofr.at>, Matt Germonprez
 <germonprez@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Gary O'Neall <garysourceauditor@gmail.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 Nicholas Mc Guire <der.herr@hofr.at>, Julia Lawall <julia.lawall@lip6.fr>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 Rithvik Patibandla <rithvikp98@gmail.com>,
 Dheeraj Yadav <dhirajyadav135@gmail.com>,
 Deepak Patankar <patankardeepak04@gmail.com>, Ian Rogers
 <irogers@google.com>, Bhavna Kosta <bhavnakosta2020@gmail.com>,
 OpenPrinting <printing-architecture@lists.linux.dev>,
 Akarshan Kapoor <akarshankap@gmail.com>,
 Gaurav Guleria <b20099@students.iitmandi.ac.in>,
 B20251 Kushagra Sharma <b20251@students.iitmandi.ac.in>,
 Mohit Verma <b20215@students.iitmandi.ac.in>,
 Pratyush Ranjan <pratyush.ranjan911@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, benjamin@zephyrproject.org,
 David de Barros Tadokoro <davidbtadokoro@usp.br>
Cc: Aveek Basu <basu.aveek@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the Linux Foundation will apply again as mentoring organization in this 
year's Google Summer of Code.

Note that GSoC 2024 allows now 3 project sizes, large (350h) and medium 
(175h) as before, but now also small (90h) in addition.

All the rest is as last year, especially allowance of open source 
newcomers and not only students and flexibility with the end of the 
coding period.

On January 22, 2024 (tomorrow) the application period for mentoring 
organizations for the Google Summer of Code 2024 will start.

To be successful, we need a rich project idea list so that we will get 
selected by Google.

I have set up a page for project ideas for the Linux Foundation's 
participation in the Google Summer of Code 2024:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2024

Please add your ideas to the sub-page of your work group. Also remove 
project ideas which are already done in one of the previous years or not 
needed any more and make sure that all contact info is up-to-date and 
all links are working.

Make sure to not talk about "students", but about "contributors" 
instead. I have, at least partially, taken care of this when I have 
copied your sub-group pages from last year.

Also make sure to remove the "**To be updated**" phrase after having 
updated your project ideas.

If you have problems mail me with your project ideas and other editing 
wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and 
did not have the edit rights already from previous years, please tell me 
and I give you edit rights. I need your name and e-mail address for 
that. If you have an account at the Linux Foundation, use preferably 
that e-mail address, but having an account at the Linux Foundation is 
not required.

Please also take into account that the deadline for our application as 
mentoring organization is Feb 6 and after that Google will evaluate the 
applications. So have your ideas (at least most of them, ideas can be 
posted up to the contributor application deadline) in by then to raise 
our chances to get accepted.

Please also tell us if you do not want to participate any more with your 
workgroup, so that we can remove your sub-page.

    Till

