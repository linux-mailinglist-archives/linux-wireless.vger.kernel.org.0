Return-Path: <linux-wireless+bounces-1256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF981CD8E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 18:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40447285594
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72328DB9;
	Fri, 22 Dec 2023 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcLCIu4M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A99286B5
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso24725605e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266024; x=1703870824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6UoWw19s8ovd9rJSJ1T7lA53hk0qRRDCSJG3HdfXZU=;
        b=QcLCIu4MAcHUuPYUOVhGoWIGmVLHrFtZmwASy4nhC0XkmSxqvUwANODHgz1K7NxzPy
         s0J5zgAg4IQP1iWyvvGQ1ncEcctSQhNFYNdysfyPdChPfzNlTnCq7JhFMxgD+bZ7iTef
         BiHMzEMApwG3GFjCy8VVzavc/gv+yJ/+tSKq2d29QnlYCmaPULu1w41b4ILGd/w82vPd
         h3y5BjuVEkrxA+22apBcwG1TVzJCZRumpIN7tAZQLfIOMy1gKXYXrqLLoZrpfGt6eiIh
         zx90OBkqUlxSwwITRzVZGPLd5jOs/2NoDKzSxQQrXA13DzcUZkIqcJ0Gc9LJqI8QWqOk
         082A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266024; x=1703870824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6UoWw19s8ovd9rJSJ1T7lA53hk0qRRDCSJG3HdfXZU=;
        b=eh1liGIy3XIa7oqDVUe6mekFJzDJ6L4YJRo49uVMHpU5JZz0f4e4LCr2lqyU0tjt6y
         1FXwDxDbgqJ61kKxmpQeq3RLo1Kf63UoWDdbe9vhzC3quD1aUYPwg+eC3diW045t9vl2
         bLyx4AoZNsKV5qbv9Sm+5pu/YtzHtgfhHLKCWCfhuDmNPh5FqtGA0mRTVWn0OtGHJFa2
         1gL4BKv4q88uM9hgXbKQ/9bGGGR6Ky1c1+B1Pw4Ss0YINw8kjHzv43wLeuZkQ10MR92a
         O1qSS/Aso6bGiPwffV5dtv3v3bOdrZTm0tvfbEHl5u+jdZ8ujoLuKSWNosXVRBRDeb+0
         xAZw==
X-Gm-Message-State: AOJu0YwRcmD62KNJyc/uD59dwZ2ZcJCVydgNg53O0LGlrUKid1KfpC+B
	kUYgQwJV3p1EcPosdX7Fj7kYZqHXJDga4EygAqesQYjg7O8=
X-Google-Smtp-Source: AGHT+IEhW1uftYjtDK3nFIcups7JpY/MammTBVINv36Y08deHP9Vqg+yRA04sYHNFhElJHfqpzIjLCWWOtuWQzh7SaU=
X-Received: by 2002:a05:600c:1896:b0:40c:3555:e230 with SMTP id
 x22-20020a05600c189600b0040c3555e230mr849249wmp.46.1703266023876; Fri, 22 Dec
 2023 09:27:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhF1GbgND_-h2yT=E5vgaatj6gUXJSt3tHo==TSeJOaj_w@mail.gmail.com>
In-Reply-To: <CAAMvbhF1GbgND_-h2yT=E5vgaatj6gUXJSt3tHo==TSeJOaj_w@mail.gmail.com>
From: Steve deRosier <derosier@gmail.com>
Date: Fri, 22 Dec 2023 09:26:27 -0800
Message-ID: <CALLGbRJxm5U4BqiH3Z4vGMAAvBhOcZ83ZvW4yt1=43ZRp8sNYQ@mail.gmail.com>
Subject: Re: Patch submission instructions
To: James Dutton <james.dutton@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:46=E2=80=AFAM James Dutton <james.dutton@gmail.co=
m> wrote:
>
> Hi,
>
> Where do I look for patch submission instructions for linux-wireless ?
> For example, which tree should I rebase them to etc.
>

Work is done against the wireless-testing tree. Documentation:
https://wireless.wiki.kernel.org/en/developers/process

- Steve

