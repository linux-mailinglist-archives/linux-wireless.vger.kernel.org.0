Return-Path: <linux-wireless+bounces-19566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6076A48A7E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA67A56D2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FDD270EC8;
	Thu, 27 Feb 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdIYL2EA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD71E51D
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691796; cv=none; b=BULyt2UiWAx251z3irpHxq9LYTY/1u1OpkKd/8cCAK+uif/Lc2Zf+3xpJAQbhci5FAkMMaZIDAM3NwupWjKnHV7EozbNpqfupEQDsVySvybiTV7ZimAJIYu1irjuwR8/IVUrcF+ya7lmB+O5W6yf1N2E5p/TXn2jV95kYpTJj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691796; c=relaxed/simple;
	bh=IbhFrwvrOeKF+rXRRkZ6fqZl5K1adBxM3bk6gjsCr2A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Nteplhqt/MgUyt1O0M88W5thkldRewFGVQvGmjJvfWVqWse6vwKiMWoyNKh63Dq9PAwNH9DY9y2TIlYdigeg3vMtLyR9zcwlx5T02GIgS3Q48WtSWRVbr4XRktbT3tqMSDxQnjSqhuzZQrDy4p1BYvWCj7IfNHieX3mbSKgugPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdIYL2EA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f406e9f80so1164579f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691792; x=1741296592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRDBPJLvEEnaQNddtrHjN36HP6FLHCQ7Z9gf28EHYyQ=;
        b=ZdIYL2EA+oRJoTB4teeqhO0FRW8lg/U6joBFDHBTUqBm2eMvp/z8CjSTIMwWhSLdIN
         Z/joL/C7AEBlebgyEidGU/t9ZixCi1ZsXLIHvUU2viQS6/SSAp7FyslIfU+6n4GXLW4a
         ngqF3AMRR8RrH1Q2x1fgUxYrtMs5mp+I6Tj7Ai2eBpF+DQ6Od98NdiUA2ttTVAQ7DAyY
         5L6PDqcKjZakJ66fNGQWdLbyT71QzOds9n9XWQtzrZaT/Lg+TOqpygvAPVJbmmt4FJRK
         5E+ya85XUtuGXnhIZ2YTJJLQOFlfyEAwnYWfe4tIXriCvs0ga9jodIWuLss+d1ja7eWP
         kmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691792; x=1741296592;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRDBPJLvEEnaQNddtrHjN36HP6FLHCQ7Z9gf28EHYyQ=;
        b=fY4Rk6pjkCOAfnM4zci/RNfs2lK8j8Uf5vZTGH8z+wMqQ/jeK3Y4dMnhDg47X6gBPu
         r4EyiANHZY8irZuAxm/P996n+lXXZqSSPfFHGWGy32Q6SGJx3+tUygVpRM0Ehkld1S5u
         5a+dkWR0sDsr5AcYuhxKXEtqKAagKyeWX9bafDCk9HxOrxv09TZp4J2QrecZJGn6g6wD
         OEEbBIarkMbGE1YlH9+uuMSWDG7+3E6wfySQ9DVauGCm79g339QgcYE2KrA+6rZNtEOx
         vtczv7DjZof5r08Gtpf72uzsQjF5sse6/XBhUqaCVtkV8k3T4sXFTYnCnW1nTn0HQp4h
         P1eA==
X-Gm-Message-State: AOJu0YzbR9PlHwMXN55NmAUZICQE1fy8SFpNd23tmDMKlKCy8Gbxgfo/
	W8TP50LY3xOdDcjzJchcPOoJeaMEKTyb+AfH5Oi8YWoODTEs5FD312QMvulW
X-Gm-Gg: ASbGncuJzZbvgafD0Dy+B9/GvFtilHOm1YJXdos5Q6f6gsWyXbSgGm8ykbpw58sWXJr
	BRGZ8Elg4TCFu9g8zGoRnloyire/OICIdvW6t/L6IBDUwwrAOQ8euKB7lBEWVa3CwI/Ll+cVgE0
	6t8iIbwWPhuiN63/mCdMOBWABtRgCMwuDgiO5tZDxCu4ScFmWZoiC5ExzoXjQvZ5WOaxHpXm/jF
	t1PC+0TJ+m4BU2GpILp0KNvJ3x18KJ5RqXlp76tv5cklqxwsSbEUNayQj+I5TVZVs+gLZKqyBik
	08yht7f0YxlKawfCqzQVAgt8lxpjyu+vkBnMacqXnzMsXCCW4mGUn+XxWlQydunPWORC2oXTz/L
	Q
X-Google-Smtp-Source: AGHT+IEKZ8+K3elsWBF3oFFJO9FkjEZviLfgLdFR2V1A6jtdwNsnNDTCkVrzdkzSE6E1gvkn+9meZw==
X-Received: by 2002:a5d:584f:0:b0:38f:355b:141e with SMTP id ffacd0b85a97d-390ec7ca397mr667746f8f.3.1740691791713;
        Thu, 27 Feb 2025 13:29:51 -0800 (PST)
Received: from [192.168.68.113] (194-96-30-82.hdsl.highway.telekom.at. [194.96.30.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484489esm3267490f8f.68.2025.02.27.13.29.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:29:51 -0800 (PST)
Message-ID: <878385e7-a28d-4aff-b849-ca12489d992b@gmail.com>
Date: Thu, 27 Feb 2025 22:29:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2025 - Linux Foundation accepted as mentoring
 organization! We need mentors now!
To: linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

today the mentoring organizations accepted for this year's Google Summer of Code 
got announced, and the Linux Foundation is one of them!

https://summerofcode.withgoogle.com/programs/2025-ao/organizations/the-linux-foundation

This means that now we have to everything to get amazing projects going this summer.

First, you are probably all actively working on finding contributors 
(open-source newcomers or students), familiarizing them with your code base, 
integrating them into your community, giveing them assignments to learn about 
how things work in your project, ... If not, start with this ASAP and do not 
accept candidates only showing up during the official application window in 
March 24 - April 8, or even worse, only their proposal appearing in the list you 
see after the deadline. The earlier you interact with the person, the better you 
can decide on whether they are the right one for your project.

Technically the having gotten accepted means that we can register mentors, and 
as in the other years we need as many mentors as possible, 2 mentors per 
contributor project we want to run (usually they do not give us more contribuotr 
slot than half the number of registered mentors).

If you want to mentor you have to register as follows (According to the official 
e-mail which the org admins got today):


     - Returning Mentors (who mentored with us in 2022, 2023, or 2024):
       o Log in to https://g.co/gsoc and agree to the 2025 Program Rules and
         Org Member agreement
       o Inform the org admins (Aveek and me) that you have done so
       o One of the org admins will accept your request

     - New Mentors:
       o Org Admins have to invite you. So tell the org admins (Aveek or me) that
         you want to mentor
       o They will invite you and you get an e-mail from GSoC telling so. Please
         check also your spam folder if you do not find this e-mail
       o Follow the link in the e-mail to register and agree to the 2025 program
         rules and terms. Tell the org admins when you are done.
       o One of the org admins will finally accept your request

There is no deadline for registering as mentor, but please register ASAP, the 
sooner your register the sooner

     - We can see that we get enough mentors and do not need to chase after them.
     - You get important e-mails from the GSoC organizers about your duties and
       how to proceed. All these e-mails are also available on

https://docs.google.com/document/d/1DFlES2qkSaVRnUBaODNtdD3eY5M0hFPfYerSyxf85Pw/

       but it is always better to get them right when they get posted.

Please also join the communication channels of the sub-group in which you want 
to mentor (in case you are not already there as part of the sub-group). Please 
interact with the contributor candidates who are introducing themselves there.

Also see our project ideas lists to find out which projects you prefer to mentor:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2025

Important is also to get the candidates interacting with the code base. 
Therefore please let them first build the code base on which they are supposed 
to work on and then give them assignments, like bug reports, to work on. Only 
accept proposals from candidates who are well onboarded, do not base you 
decisions on a just a proposal you find in the submission list after the 
application deadline.

And keep in mind:

     - A person can be GSoC contributor not more than 2 times
     - A person cannot be GSoC contributor any more if they have been mentor at
       least once.

So make sure you do not want to participate as contributor before doing your 
first registration as mentor. And ask contributor candidates if they already 
have been contributor and how often.

I hope we will have a great GSoC 2025 with all of you!

    Till

