Return-Path: <linux-wireless+bounces-3304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E62084D1C1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FB71F243F1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89C85C42;
	Wed,  7 Feb 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5YWamdv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29F85C4B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331534; cv=none; b=UgTUWESd9DV0QRHbvL3LqJnEjESq/8uBvyZTVQIAezHRtqLACx97bF5zk3RMb/W+J6w5InrlEUwGczXAAiDtF1nZRqT8m1pts87xdZVG2/uOmyyn+wRTwtFxcxr2EW31QQYn7SuVmo3p9qnnU6REkoCuHQx4xbCy4mS2BCkUZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331534; c=relaxed/simple;
	bh=mqrRj41IB3y6xNMDPsyyuhL5eSyhN6DYeigOtW2b/UI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WousatJ9t0PqiGU3lfci8zOligq7/Ny5NWg/Cr1bUO770RzHK1OUQrgOHVddpoyeZpt7Y9DSiZjJZ5R2A1//WxaDZ3O3yYyQQ4F8SbQyPrrqEmk/VkM2xJ5LgHdxSgn9kpxz2zv8B8XIWZ3FbWeDUtVtXCYDvdGaV5fisOOtrMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5YWamdv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so133192066b.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Feb 2024 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707331531; x=1707936331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1sWb/s4cVK1VfkjmTCJ/uImxseScNI9FiiDlsrNSTI=;
        b=i5YWamdvPlnfDO/Mh/duHTv01VvsVAHSjBY3scp2Yl+uZ3S1ZyM+sEFKNSdzUS0WQn
         ou36U6VIa5gqxSv1o5i6J3LEHRJrfRyzL9U4DZG1jcUKv+7BVWTMMGwivnEavf1rtf2U
         7sVfs8BaYlRTor5IXmtce7QgyjdVbUmQGtCkt3xiOcm0+iUCL0FoGUAQXK6T1RDhrAr3
         aVAS7MU78+AVMMX1xAOSiFXyFFbLBBQHrQECotoSplwnfzjVnRawaYx3teS5gTPw2HgF
         LOM9PbSokzGPyeDsR8+rNCwcarmAdbPeJ+FJ3qK1otRuONyNzM9uEs2TzymxWdV3mwrl
         IHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331531; x=1707936331;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1sWb/s4cVK1VfkjmTCJ/uImxseScNI9FiiDlsrNSTI=;
        b=edod8EUvTsWwwzQ4emDdRkPY8IGQuWbEYisgfmS92ImzfrTjF/xIzylFSubCUqI48i
         1eZHZR6f5fzpMPkuH3kx/GrJ/khZWNCbgAx+htiPxJSvnid0IiLMgAnR43m6PvO3xEmJ
         imTyMJCFlXaJ7GuNWR9xdPPvU4XetAVuxmd2HK9OsrbBJohtLTHTNhuCefug0lnGqWJl
         iyEGcz5GnKH/otdfaRexSnNQRMK5jUSObSogrrrbibnWTJRADOPA+gfO/W8LOKXT5QNg
         8xKXw4fJqqrIkARbuDJjADD8nV15egBazx5stfKGqfFfNb1FmZzOUpsRnCehwTkTjy5o
         RFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRlCVR/9USmtoFkQSjQRLvblZ9VQ5knOzx91vs5rrrVLHQAHRgWXDMy/krMGWFXuDxm+YhxDYkidqYmJrT7rwFY7peHirhiHyYjNgsW8=
X-Gm-Message-State: AOJu0Yy1Ek5RCu3jfsKl3wLMCzEBM8DBkrXOEV6xvSGx7faFfT2O6ink
	h4jTRP+hEdUU2DlxZFoQ5YphpQ+wC6Lxk2GlfFjVZM2QwxYHgrut
X-Google-Smtp-Source: AGHT+IE9H+Rp1J3SIp76MyZkBR8ff0SS1Tdt3RmFPXkYYI2g6qCNNiHKEnvCwvXH7wdWcuszQHHJog==
X-Received: by 2002:a17:906:30db:b0:a38:4ff3:773 with SMTP id b27-20020a17090630db00b00a384ff30773mr2858033ejb.47.1707331530601;
        Wed, 07 Feb 2024 10:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaRFejYn4e3EOIqHq2DRTw11H7Yv7KLCapGnHvMmWLD6TVuYjTL5yTnniXmXE/b3c0rx9iloUoWPM0tTh+5gxhC91OBAR7t/MUavlc5CrJgXevHQNfyCUtD9c9MWdxE4hndas3oP/GnB09QDDdnoQ+dC6Wjk0wN4kkUtKcOpZTLba68qROEi8O+/3tcNtagjgl3TxmSu8kmpVsQHT9+W/INpRJ/qX3JX2OfGRW4bTelzwHFzuNmg6IxK9U6Dv+i/6BdG9F5JVgeL+8h127KtCeOCfwPyGaSLmtxfNXhrWhiy2+8f4sM9LAyJl8udqs9d9mtix6p25tu8jzxlV69kJMEC5QqawW8m3STPfYPhDSFCt7LNo68pxdsY/E1tYkxlp2CHm81jeQG01TNbBwJ27W3LH2Q8Q3taPnH1q3q251oNXDggoeZnuZSFzTpb5YdWRAob3jrs3PXX2Om2zjevHcg/+W4h0vVW9Jqt0tCJUy9X2KZ9qOId6h/S/KHmyn/cueBK8GgX501SnDKspPh+pqXvY52PgNgDDVusdm84srQ9IZYOI0UjwhNJeh+YNycsl9XJgOoJ93Hrv1wEJs42v/A/x6sDV4MRAV1Pvrao2Iu0jfzdfBy3SCl7gs7/Mbt2JM8MH7AGUgpcLI6Id9d+ZYQ14QWhWtWoa3lxfhWW3TOS7Jvu3Xjy03x9/48DnyUWU+ZjVMXgS1ov80rSk/5jkkQ2sT1EfiCnhPoSKvyUxt4w+QzPOvsmJEPaDSXPqqhBnC8ZivIU4aSJ0C585P/TlCLKIfrSaXfbtQGAa0mfrkB06Zvz8nZRt3Vyv4pdcX4qUbPyOBMQDw0wwraRgQzf9b87DgAPqI4nPweC0N9EIej2Ire8L1P3DWL3ztVtegFcRgru0tKigAFj8pd/YooWADmyMYCjW9yBkbDhHzYgJwI+uPbrLA3N16UOugB598oUYp5o
 al9+Gaq6i0iX1hQAb4qdqKLpJJrpoqywXmcSqhJx9eIvMOiwAMHVDE9fsVRc+s1k260Hwe1dhRZZvI3nvKYZuK4NiVWhUsqiCmI263c+7vvzlmkHGfQ78/RHexStRWiGfxsZLWs55MSy4pMZhTV6Adb+vzJt6oTPqxFFKicLapOQw0dFVVW27zG3D0swObOgTPzZrHOmMZ4EITnq0hD/SGOG3Uu6eq8EMBOlXcvonzhhHhsPMxnvidmQE8/HyBdSPdxLTygbQ0LzgGdCk9idx9yjdtnwsO+lnLTnie6BRe3pVtyl0=
Received: from [192.168.68.106] (178-191-200-70.hdsl.highway.telekom.at. [178.191.200.70])
        by smtp.gmail.com with ESMTPSA id hw19-20020a170907a0d300b00a2cd74b743csm1042206ejc.3.2024.02.07.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:45:30 -0800 (PST)
Message-ID: <7cf9c784-636d-44c8-a9f9-89f4e13999eb@gmail.com>
Date: Wed, 7 Feb 2024 19:45:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Google Summer of Code 2024 - URGENT: Please add project sizes and
 level of difficulty
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
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Jon Oster <jon.oster@toradex.com>, siqueirajordao@riseup.net,
 peterz@infradead.org
Cc: Aveek Basu <basu.aveek@gmail.com>, Stephanie Taylor <sttaylor@google.com>
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
In-Reply-To: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

we have applied and Google's organization team is looking through the 
organization applications. There they have seen that we are missing 
important information:

1. Project size
---------------

There are 3 project sizes available:

- Large: 350 hours
- Medium: 175 hours
- Small: 90 hours

Large was the original project size of GSoC, 3 months full-time. During 
the time Medium as half-size projects got added, and this year we have 
also Small as quarter-size projects.

There is no requirement to offer all sizes and you can change the sizes 
depending on student proposals.

Please add the aimed-for size to EACH of your listed project proposals ASAP.


2. Level of difficulty
----------------------

This is an important orientation mark for contributor candidates with 
different experience to find the most suitable projects.

Please mark EACH of your project proposals with a level of "easy", 
"intermediate", or "difficult" ASAP.


3. Requirements
---------------

Another important orientation mark: Tell here in which programming 
languages your project is written, which libraries are used, is it 
Desktop, AI, server, cloud, ... So you will get contributors who already 
have experience in fields important for your project.

Please tell for EACH of your project proposals which 
knowledge/experiemce is required or helpful ASAP.


As an example see the project idea list of OpenPrinting:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2024-openprinting-projects

Also do the following ASAP:

- Remove project propoals which are already done or which you do not 
want to do any more this year

- Remove your workgroup's page and the link to it on the main page if 
you do not want to mentor GSoC projects under the Linux Foundation 
umbrella this year.

- Remove the "To be updated" on your group page when you are done with 
your project idea list.

If you are not able to edit, tell me ASAP so that I can give you edit 
rights. Tell me the e-mail address to use for the account. You will then 
get an invitation e-mail from the Linux Foundation. Please follow the 
instructions in the e-mail and you will be able to edit.

Please fix your project idea listings ASAP, and please remove your group 
ASAP if you do not want to mentor this year. Also do not forget to 
remove the "To be updated".

If you do not answer and your group page shows evidence of not being 
edited for this year, we will remove it.

    Till


On 21/01/2024 23:50, Till Kamppeter wrote:
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

