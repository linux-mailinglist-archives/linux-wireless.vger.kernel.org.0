Return-Path: <linux-wireless+bounces-2301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AA8358C4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 00:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07C41C216CD
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 23:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2638FB3;
	Sun, 21 Jan 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Kr8sah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EA38FAA
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705880080; cv=none; b=Q+IdZfEkjiI7Gx9R/RxY4qVzCQ/p6yPLCZ2I+ctN+JJx9QR8rML4LllJRya+aOxRw7KjWI6OJ62xyljkNlcz1nciAoeytTGtR31ROp8A/cr3v6hp9odUlPShop1oOd8et8dn3+Nxo1HXUammuj67wq1L33CetEO83bSSp8cRolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705880080; c=relaxed/simple;
	bh=UN9TGMohuh+2ZYrWCoymIUxeb6EkmmG+CDG2z9CAquM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iwRXxoqR4HGGbY2t9FWhx/z6IfO4UYiCUPSEn4xOmRncCxK5/OnoZNmNYCColC6T9tWv7qYq3D3+Cvf2GsxAN/vqzamSBpAb2RCVDKhwVk9FegPv0tyc8/DbJXmybwt8HsjhD19sZN9ISA4H9UVPVrtX95c1DFc0x+2TmVn8yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Kr8sah; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d75c97ea6aso111205ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705880078; x=1706484878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6NkMg0I/jVbthdXI9RpUamayA/gcrsJk3Kmnu4N4r4=;
        b=m0Kr8sahnb2WmfONivuAwAoepbPedMW147BHbBanCk4ft6nwpkoHYPhoIIF6W1maUP
         Q0YDg0ir29cu0H6kb/nC9iKYmG04QDBmuS2/WG9XRD3aBJPRG/pa2/0iPIMKIj8Tv8uI
         QvFJkrz83GvojxYCkWqa8JOgfPpltO/zfzaa5IoJkNNtZIEx9GXucuEqIJl6S7GEGMot
         W/xDWvfQfomhfwmgj6OpXYEoor8Ew6swHYMips+yWO3RJuwzmnWiGxH0zmYKWALfN4pr
         /ljkk3ooHZw2eiSozLsMzlbVZ2iDHXlD7DmhuNbFjAK6YPDMa19qZ6FfSoNG+0IhjESf
         ShDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705880078; x=1706484878;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6NkMg0I/jVbthdXI9RpUamayA/gcrsJk3Kmnu4N4r4=;
        b=CdjuK7KrcSa49uNs7G+lHne+v5WNf3ij+ABULA8qoI7YbugWIndWwKm7TuyefFvTl5
         2frsp2D2WsX87v1/dhF1AfwyE040poOFxD0kt7eu0DTT5kP8+rV0juaLgY2uqFtMAimM
         ewUv+hYj6ldH30x5jvxDGGGcqAJsJMrw0gXjME/zF0t2WIj946+JXFBqGO+3kMDN8C9P
         WbcLorWjS+h+vynNLgVzsxuw1dSUkKQrQM1aek9+JoVJNA4qcmAk9SCkbaBUHfCPhrrW
         tnoOIx4tWeZwyM8p36KjyPup701+i9TW2ZtFoYqntnwnm7dZprmeY3kGyD6QV20GxOLm
         xK5Q==
X-Gm-Message-State: AOJu0Yww67Ue9HLK4ScETv9YV1UXwDUpVqxeApjAvJmHFmUb6FQwPxWu
	LMnFivrQQHQF3FfjO67fuAc7BYB9L6TknqmMiBU3SF+/gycA5Vl6
X-Google-Smtp-Source: AGHT+IHy+udVeSjaBgsyX85QSFuD5vRssLwN1WbCHESyJDFY+Z8xteq51ArUIF5dS8OlW99ADlvk0w==
X-Received: by 2002:a17:902:ea91:b0:1d4:1809:7b86 with SMTP id x17-20020a170902ea9100b001d418097b86mr5366955plb.53.1705880078300;
        Sun, 21 Jan 2024 15:34:38 -0800 (PST)
Received: from ?IPV6:2804:1b3:9403:d83e:b794:f318:e42b:4815? ([2804:1b3:9403:d83e:b794:f318:e42b:4815])
        by smtp.gmail.com with ESMTPSA id kl5-20020a170903074500b001d72d445778sm2897181plb.204.2024.01.21.15.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 15:34:37 -0800 (PST)
Message-ID: <c947fa14-40ae-4736-a951-ec47738b79a3@gmail.com>
Date: Sun, 21 Jan 2024 20:34:27 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Google Summer of Code 2024 - Project ideas page for the Linux
 Foundation online
Content-Language: en-US
From: Till Kamppeter <till.kamppeter@gmail.com>
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
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
In-Reply-To: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Two additional remarks:

- This year Google wants to preferably have AI/ML-related projects, so
   to raise our chances, add such projects to your project ideas lists if
   you have and mark them prominently.

- If you are using Mastodon (Fediverse), please post with hashtags
   #LinuxFoundation and #GSoC. Also if you are using a hashtag for your
   workgroup, add this information to the contacts part of your group's
   project idea page.

    Till


On 21/01/2024 19:50, Till Kamppeter wrote:
> Hi,
> 
> the Linux Foundation will apply again as mentoring organization in this 
> year's Google Summer of Code.
> 
> Note that GSoC 2024 allows now 3 project sizes, large (350h) and medium 
> (175h) as before, but now also small (90h) in addition.
> 
> All the rest is as last year, especially allowance of open source 
> newcomers and not only students and flexibility with the end of the 
> coding period.
> 
> On January 22, 2024 (tomorrow) the application period for mentoring 
> organizations for the Google Summer of Code 2024 will start.
> 
> To be successful, we need a rich project idea list so that we will get 
> selected by Google.
> 
> I have set up a page for project ideas for the Linux Foundation's 
> participation in the Google Summer of Code 2024:
> 
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2024
> 
> Please add your ideas to the sub-page of your work group. Also remove 
> project ideas which are already done in one of the previous years or not 
> needed any more and make sure that all contact info is up-to-date and 
> all links are working.
> 
> Make sure to not talk about "students", but about "contributors" 
> instead. I have, at least partially, taken care of this when I have 
> copied your sub-group pages from last year.
> 
> Also make sure to remove the "**To be updated**" phrase after having 
> updated your project ideas.
> 
> If you have problems mail me with your project ideas and other editing 
> wishes.
> 
> The ideas list is in the Linux Foundation Wiki. If you want to edit and 
> did not have the edit rights already from previous years, please tell me 
> and I give you edit rights. I need your name and e-mail address for 
> that. If you have an account at the Linux Foundation, use preferably 
> that e-mail address, but having an account at the Linux Foundation is 
> not required.
> 
> Please also take into account that the deadline for our application as 
> mentoring organization is Feb 6 and after that Google will evaluate the 
> applications. So have your ideas (at least most of them, ideas can be 
> posted up to the contributor application deadline) in by then to raise 
> our chances to get accepted.
> 
> Please also tell us if you do not want to participate any more with your 
> workgroup, so that we can remove your sub-page.
> 
>     Till

