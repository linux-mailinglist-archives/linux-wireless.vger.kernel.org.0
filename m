Return-Path: <linux-wireless+bounces-15012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D09BF41C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 18:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA041C23618
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CBA206976;
	Wed,  6 Nov 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW502F5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EE206509
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913205; cv=none; b=GsnQfVW3iW/zFUvXvjaMKx96r0pND2pupt58dPou5O++3eHsTsEQBhPKHCQtF9SN63vDAItzslhgHzMvADps3KYVGLyhoigWw6VYMBbZAkPQbf9lADd0d5MsTSJ6dIgSPnShiFJwESmZ0KH8CcCxkk6L++h/d3f+NBJnqbjogYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913205; c=relaxed/simple;
	bh=GeT/ouLOVoC2s9nj/5tQta0zJnVlEmaEpYa8KKsfByQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GekF/8rZBEz7+tq3+d7KRvH/JDjYl3Bvug3JJeSzYWNwkQb5Pb7eN+zVLy8VNaXfpCSaUDZe2R6YbPMrxSmnG4/m3c9LmejsfqgblUqwy0IdaozmOrdb8tBWvY2MBz0me91atHOiaQtwwb9LF6UBPONjgojLUyWP2DVjUowtaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW502F5d; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so2654666b.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2024 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730913202; x=1731518002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+0NV766Seivxun/LuESlqO5hEIVKRYjpFjWMZJ1o3U=;
        b=CW502F5dYVCSwfjelbYeS09XjLcX9S2jFQIJFvICribzsAfsOl7BDRTw9z/len6EK7
         NIPEV1/w6cMTvNfJAYTnkcJszJ378qbD9M9yBKOhbQX3H3/QhssLBB7Th0A2KlyIu6F5
         eHfJJWgfK5hLlON/PEW/gJDttLv8XgSbWF8Q/ITNnS1xyVnRmz8k7Tx5GBLkkb4iHy49
         Hutf2Tx1W/dby7IWjmpL1XTBJA4baCXco2XuiwdOrtA7OQD1w5m7ZDK5F+wSAQyVaXKD
         CrbWbJ6f+6rTca2Av8Dn4+KUTWi01YZGbgtVVAwVN1pf7PQY/7WBxBdN7BCFzoEHOLia
         Eqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913202; x=1731518002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+0NV766Seivxun/LuESlqO5hEIVKRYjpFjWMZJ1o3U=;
        b=lX58x0O5f7oEfhfIeY71FD/OJy44iMHHWjKK8Ao3bl1DP0t0AEaEyzqjmLZr/a+eRA
         bUezNqs+yJBcVQ108tYGNtK+jCDywoYFI51xBIP/5h5KrNN1Yk3r+SgSFqWtC9ygH0V1
         YIV8du6ZN2E6zGqrDhlKYmwV3t/n4W+6owjNQDYzbx4jqxVGrTs/igOeY/RPXZpQWjqz
         AutQ/G5ZrDasZwGUNBwcopIo/mvSE0377vKK2SqS5YVCbiDmw52axsWda1vG4NUhxK+v
         g0FrEtJ/Z/6zpz/2njxWxKRzumpXSAt0GCN3C2zKhdrJ8HPwwe6h1DjiNZm88iDVyAEC
         Dthw==
X-Forwarded-Encrypted: i=1; AJvYcCXftBgf2ksYaInyAyYsklXh5jwMdrXmk0qkq1SmJ4icV1VmvuB6ic6yd/p2Q00s2sh+t81Rx3Klld0ABsoYcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZtwFZkeMvaPK7V6X+HGDSHxQe8ga5L+ilPxVJhIU6lv5E5L+
	yyDPW/lDPvRbGFjilHKVy+6Th1VFi0izNqNfdaONOGv2taOyUblfulIWMGF2mrXemM9oCueFmZa
	arKcWBl0uzZVzHgRVYXUop8NYR9fP/z2m
X-Google-Smtp-Source: AGHT+IFKdlzQTW4jQ3GFsSu1Zw5ZOVnsPZS7hjhlQmQw63nhSPZ9mGpqdPOZSixgrowSISMuOt+RSwI65pvIrNu8j9g=
X-Received: by 2002:a17:907:94cb:b0:a99:e59a:1931 with SMTP id
 a640c23a62f3a-a9e3a7f0618mr2972355066b.53.1730913201695; Wed, 06 Nov 2024
 09:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com> <87wmhg61yp.fsf@kernel.org>
In-Reply-To: <87wmhg61yp.fsf@kernel.org>
From: Andrey Batyiev <batyiev@gmail.com>
Date: Wed, 6 Nov 2024 19:13:17 +0200
Message-ID: <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
To: Kalle Valo <kvalo@kernel.org>
Cc: Alf Marius <post@alfmarius.net>, regressions@lists.linux.dev, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I've only tested it on my 3945. I have no equipment to test it on 4965, sorry.

Regards,
   Andrii

