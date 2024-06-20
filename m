Return-Path: <linux-wireless+bounces-9306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605C910578
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB640286E11
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D521ACE6C;
	Thu, 20 Jun 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6n6kKFF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FF1A4F12;
	Thu, 20 Jun 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888791; cv=none; b=WzYqavHjWGDmEBT7eDL+uTP7bK3ax6/2Br/vUGT0YPzjJjma8sC3aPvuD02WCiKlf5lEpHDWAAyGJY5g4edeVT5u+894lQ0pXDcIiMVXlJXOWNDQ5VY2UKmsybpGjDJBD28kTuUXqgnYd5wJKEHOrRmhz+aK4AXvKv4UGLwDVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888791; c=relaxed/simple;
	bh=U/Vzc484+V4lv4x3ivcc/NCSIiHpY+euyvJkYjGSyoM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NAgQbMFY/Qfnr9eMoCyxO/Ew/xM9MV8ndMJDJ3ocOALOd615p2quYrGnPplH6vpol3bcrWWQjV2jZluCBysVjAlwMttjMRkuYQDi1rrcXNATVGGnPaKSZuWfMYeIqM8f17Jegsq3jNpgsi2feBYmzrGBQyq77tx8r6o2tdTCn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6n6kKFF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9c6e59d34so7299015ad.2;
        Thu, 20 Jun 2024 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718888789; x=1719493589; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Vzc484+V4lv4x3ivcc/NCSIiHpY+euyvJkYjGSyoM=;
        b=A6n6kKFFGSf1YfbxY/dtmbhBEp8Q4YllX+HodiXLmBx7Ln2jsbHZG00YIbXLKt/jMc
         6hniVJXyCfW5LxnvyUXkRUK7SRQrFFYXxyTmWCoKnVd7VJjTPIglfRYhBHJ+FA2YyYML
         ajCUryhKxZwcqoFbsUJgKBURsM6bsRUCroOtO8hZN8CjIbleOxZC+wFtPBMzGWViVnab
         StJef/r7gFfDl7HGDaMeZAeuAMAVrLEtoBoe8h09afTqRMIESCB1Zlp3faW7P71T9ntt
         3pczOd9J42CI0tYhkr5hiPOnyw61kkQQPTDcmhdTc/ALC09gLG5UQ+e5DZX5ytW7D5tR
         3f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888789; x=1719493589;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Vzc484+V4lv4x3ivcc/NCSIiHpY+euyvJkYjGSyoM=;
        b=gkTAvY4/9NRruQCYVAXDyEj0W32KzIFW/G3fhUF/SNh+8ieHx4fzNcHuGX0Mq7PSiq
         72tIour2fAAce2f028bmp8Pvwf+Tw2Rg6F3+ulmgzgX8+xff9LKpbSYOrYTtkJDl1Eac
         i3MyXHXtaz4sPfRukKekmlkdPRAAePe5f9v54XnrYK5n+WGpd7wv7kAUcdISqYVCs6RI
         Zb08ZZN2a5vL3Bk8vHOWN/qWpTZFFjLLPmtJ6J62lRskXa7L9TmkeG188Un4X+P1I6EP
         6MB75h9gHtEtftv4CnAFd5+cBEL6QFL72/kLuV5oOt/7xqev5OIqErITuxesiE/3Zq52
         Uc/A==
X-Forwarded-Encrypted: i=1; AJvYcCVChgNjMHnUjD8hNO1W3PvxD6l2yBUtid+EEXKw6y6b69HT+spxD/0/xOs+zBbjtKDAHdXqkL8zJZh1nUzTkQ+s1+0HF/tL3F8=
X-Gm-Message-State: AOJu0YzmaklRpBIImHGDijHOlRrGNS9Rl+Seqy1KJ2ZEKRAeqUSekoh2
	o7DmD3tmhvbbZgG9w7fry3LAUK+RUq2UtvHPUuioJf6NPfsU8qmv
X-Google-Smtp-Source: AGHT+IFWZjnmSAWvGOgm2kZzT3GlgTGUhE3W9jMnpBnvaQnIigpbklefAahul749zLDiOzMOeBMCiA==
X-Received: by 2002:a17:903:1cf:b0:1f9:8cd9:96c9 with SMTP id d9443c01a7336-1f9aa45a571mr55098045ad.46.1718888789187;
        Thu, 20 Jun 2024 06:06:29 -0700 (PDT)
Received: from terra ([122.171.17.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8489sm137619945ad.167.2024.06.20.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:06:28 -0700 (PDT)
References: <87tthpwkqf.fsf@gmail.com>
 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
 <6970398610c546b1b62e599902c67572@realtek.com>
 <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
 <342b6b95d97a4bf09afee15c09481efc@realtek.com>
 <CFB0314C-AE45-4563-BF41-F5D635BFCF86@gmail.com>
 <a60692b7a0ec4caa5db64d369bebf18910102656.camel@realtek.com>
User-agent: Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0 Lightning/4.0.2
From: Forty Five <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, Bernie Huang <phhuang@realtek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Freeze on resume from S3 (bisected)
Date: Thu, 20 Jun 2024 18:35:24 +0530
In-reply-to: <a60692b7a0ec4caa5db64d369bebf18910102656.camel@realtek.com>
Message-ID: <87jzij7ohf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Please provide output of 'cat /etc/lsb-release', which Arch Linux version
> should be there, to me.

I don't have that file. But I do have `/etc/os-release`:


NAME="Arch Linux"
PRETTY_NAME="Arch Linux"
ID=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://archlinux.org/"
DOCUMENTATION_URL="https://wiki.archlinux.org/"
SUPPORT_URL="https://bbs.archlinux.org/"
BUG_REPORT_URL="https://gitlab.archlinux.org/groups/archlinux/-/issues"
PRIVACY_POLICY_URL="https://terms.archlinux.org/docs/privacy-policy/"
LOGO=archlinux-logo

