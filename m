Return-Path: <linux-wireless+bounces-4356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87121870B7C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2117B1F20D4A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1477A15C;
	Mon,  4 Mar 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfY8tuVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848C4AEF9
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583848; cv=none; b=FzOAt1jH3JN/Mltjwd7giz1YVC6yG0+G9FIC5uWKT5RZJfALK1rkbnI3t/9RTt7/t78pTJ+SxwaMhePb6dsdaAIxRFCByy1Ln7yFJC/lM346jzhfI93TuCYTceISkfp0nCOSN6hdH1CNHu2S+LNeX4yttETcPk9zEGm42v9pabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583848; c=relaxed/simple;
	bh=rLWY1hy1TmW2E90o7x5PfT/fcLVzHwpQDX77Or+vk3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BskoxodTLq4G6o+9SRdJkX1NwsHkuuKjK9qJVKpxo2CJ9ccmcq7yOgynWSHonmvl/JmXC7tQ9Ei9A40OxQ7B3qGRyq0HHjba/fcjzRJ0zNhYKbpd8F/4hbowJ0HkkoxVFw51WvbHXJg6b4RYEaL6uN3GJbU1Psko76A4KKKk39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfY8tuVQ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5140420276.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709583846; x=1710188646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLWY1hy1TmW2E90o7x5PfT/fcLVzHwpQDX77Or+vk3I=;
        b=IfY8tuVQXORb3DaLhyUtP+OEzXnntOfBC9OFZFPVwwwltRR65rixbNiwwhyNiPBj8B
         uIcJzlx5vp6Su0uLSptQ6fzs7s2xYCk2o7VKYCYvRNbSyb8IM2UkNbGVEWZ5HJPlktEn
         DUFnWHBrXOS8Fm/X9GOwkuJ0njT3B7zgoxI+C0Hra2zIF8N/Pyoi1uZJisAowkwOrCOQ
         rHb6htYQKI5WOfMPvjXqc+x9hsHuJzjFEFU1osLxNJeo+k0T+mZGrIj5gPvg3U/eWskS
         5GNtfYXbuaa4z0B0zIebHHxe3yEJxwcKainVYhf+JZ3iJxGfhqXmgJetxWx5+mcu9piy
         VogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583846; x=1710188646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLWY1hy1TmW2E90o7x5PfT/fcLVzHwpQDX77Or+vk3I=;
        b=ZdKbCfh3/S3ylMOBPc3eF1d1FMxvr5I6kdyEpx3HNdFs44ck/apUjfWJI62QI3toWB
         YEAuiOGKS9LtShEa8UH4/YMK8yiB1TD2IvjY+MCo9Z+SnbLU3IkNAztEUbEc8E7g0rVH
         21Y1xBTmwJEjd0p42dezIWiPY1a5hfOy4DZSzI91jEhlA1VCReba+cwCrXUn0BrihGpz
         56jDOAdh788+xikwr8AW3UCtijvHCXbgWVwUBhtJYJ2iJtz9EAc0iWbepTF40QMDSroq
         mRBWI9zdiT69hn83odOpYZKM48XnM6uUjCO1wyrHyqAfm4gElVpxPw7QnLPb7aD5QbmM
         YPUg==
X-Gm-Message-State: AOJu0YzVr/kdWqT9Q8Qf2OBx5NRiTTToCaE28Klftqn2sw/eP2MI+ZHS
	bL+RLcgHB40LgDV9nRHHhO5Ri2+37n7JBsWlzwzDjY051V81964NHnZhfUfAzWt+2J/dVDULFou
	Njit1ouZYwlFVNeJhtvXDQ0iPdrU=
X-Google-Smtp-Source: AGHT+IGXL9h0rXkgI/ueLyXzEaRzDbQPMkW3WuC0PzkWuD9jAyOsDBAHIwKhwd/CTA0kz3jx/BpmmNcSmfGHrAyeXoE=
X-Received: by 2002:a25:d883:0:b0:dcc:e9d:4a22 with SMTP id
 p125-20020a25d883000000b00dcc0e9d4a22mr7406514ybg.12.1709583845998; Mon, 04
 Mar 2024 12:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
 <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
In-Reply-To: <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Mon, 4 Mar 2024 23:23:57 +0300
Message-ID: <CACDmYydF7ZDSGh-9XQ5bvyAcXt1m8JE-EXMTd8mDbGcegO1gfA@mail.gmail.com>
Subject: Re: [PATCH] iw: Add JSON output options to 'iw' for scan results
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 22:00, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> >
> > If these changes prove valuable, I am prepared to continue working on
> > extending JSON output support throughout the tool.
> > Feedback is welcome and appreciated.
> >
>
> I'd prefer to look at it unmangled - can you resend it with whitespace
> preserving tools please?

If I understood you correctly, you wanted to see the patch without whitespaces.
I have sent the patch v2 in a separate email.

Ruslan

>
> johannes

