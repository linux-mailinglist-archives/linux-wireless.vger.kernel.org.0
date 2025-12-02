Return-Path: <linux-wireless+bounces-29452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C757C9A04C
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 05:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8035F4E018C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17D9298CA3;
	Tue,  2 Dec 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkcbrUF7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3419C546
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650464; cv=none; b=t+7dSeM7RNFp3qWaXoa+Uvu9OS8PEsDFJf/M8w/+gWG5mTFh2lyG6hG7N6dfjiY4U89p0A7xOxt+X3LRYoXjZS3XBqoBdRi+7tDMKtWQn8T2kfLO9v2C7fqmkgAGnCxbS5ZzCsBLef25YB5mr3gRHGsR+tAh50syGj0CVX9nyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650464; c=relaxed/simple;
	bh=58BmrBDz7Uc3sp8/l9oukobev1aIKWiCng1xbCwrtR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l1ctmcPUJ/dlvoh/Grzx/fo1ewnJ9IkZK7G/I7wH3iwZVxq12CWJLZND2QgHQZwL9zXXG5dCtvOAnF9IbLdkG3h3Wk2Pgr9NcfUIR2zb4wXr2WFDePOJbLHxwlz5qySrw5IGVbWKClldev5pI6XJzMqGJzNoxOP7aEUKh+I8deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkcbrUF7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso1231427f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 20:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764650461; x=1765255261; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlnQ5BAi76HPvHhocPivvWgaZ62tTTuvYoTCH/OutaQ=;
        b=IkcbrUF7WjJdWLr0rlr1WWbj57mALvCqQMOdTtVtjBKwG3IShu5jj0BeWm+MUaXVw/
         njddb7XcW+OY8wn7cyGrJYM6wVO1zS8aRDJ3f1Doq48GOwZDqBtd+9+Z+d4n/TElE+1o
         MH/P9qUJ3a+3ANVbhF66wTqzs4VT9epESiu82FFl8w7Ih+V9Gm3Fuy7DPyevUg6cZyNz
         ZB8o23/QN7/j9hCfgnpk4OkfvNZrKi5JK1gp09+Q5nM4ZrT/ZJvdkP9Ds9cJJLJLYAE5
         FLBZbgQ+u1PkYAMBzis/ocmB3Wf8QGgHwmVtLgckptz5OBbeaiEDqpwwRhtqbElefjYg
         souA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764650461; x=1765255261;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlnQ5BAi76HPvHhocPivvWgaZ62tTTuvYoTCH/OutaQ=;
        b=VnQxdR7iJOGSzcRjxFcrsU1KFsD/zFxJr/Gvd0PxZgsV86uDXD4Wcu9JWQiDfNCNwH
         D4ZUza7temli2rqDiy773gM7JVqcJbdGO6DlGojxRlzRJJQRrMoYxAg5YLnG31X3xI0u
         Bt9AAhznSQA+Qr5/8pUdgbH1d1XQhS4o04bXdAZjFSfDk15G0AlfGWR5ZIBcyZD54Cxs
         o+VXfUO5T+gzKJHmy2XJy8cAYxNcH9jTN+I9/fzCLP4YD74gvDhjbcvQAxp9+ZkGzhNm
         nBSj2XCY4+kBifJ4/JhowzehWmJIPMud28r5o8+XTCCrGdKakvIg+f76FWG35CD+e5tN
         1dWA==
X-Forwarded-Encrypted: i=1; AJvYcCWJqJ5YIzT+xaqJ588nGsEgbI2VaGLK3DaJcjCCj2Waakt9gq5NaaRH+9kI3TW7ezDUpPNrXeM5muwDUNwU8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh0X+MKowrcrMUQ04p+G8X9jqL6eH/8bLtBMRuMbirgyASBsb
	fWqGfr0I5J8T2C3twUmftQji1NtckxbUGZM6Rzr5452OnTynqis6LF4h
X-Gm-Gg: ASbGncuH+WPw08dTKlVqClpGCpNEzwRS8FReRSxFffmeyfQ3hvnRpfD3zpr2usvcweu
	zg+8+WbBUky9Trvxq3ysMfhNXACeQtLZmoBpsuOXg3wIA8LeHtFl1OBPsqfExaFVj8HyLLNLyrz
	4u+8JWyreG83Xm0bHoWYCPcayaBcMinNMxjOe5k47iK5VgaZg/uNrkOqrs87M+3nWyNSYcojixb
	2TXFBAX6d442FptNCX8PdCAGS7l2bIkMoMRGI15Cyh20qNtqh7cSQs6mwZ1PNIevI4oJqAt3bIv
	eE36qmEG54BIfunZpVNQ+Sz8KenmsG/qWhvtogGCXtYPhsbsa9PugLVxmmaT8uDqZAbqqcOWM2Z
	S8pw3Nu/l/wvAsojUqpy1h6jPq2kGGVqjQS9PbxjUf9FeAHZYBRrUxb7h155Djl0zo62WJ8HfAh
	vVrStVUwB84UfwLgZ6OzHovqvAfR1bj+TpqCxRFewuZDx7UCs7l7usvsM6zA/fsi/f/a6w0nkqD
	t372G3stg==
X-Google-Smtp-Source: AGHT+IGBVfHoicF0puR2bTLakkUtiMzuIbjHAPDFKoGgk5PNnZl7XxNKNFA7iFYAa4+wXIUlMt2vww==
X-Received: by 2002:a05:6000:26c4:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42cc1ab8874mr41867616f8f.3.1764650461201;
        Mon, 01 Dec 2025 20:41:01 -0800 (PST)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d607csm30712057f8f.15.2025.12.01.20.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2025 20:41:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH] wifi: mt7601u: check multiple firmware paths
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20251201103529.1874a869@kernel.org>
Date: Tue, 2 Dec 2025 08:40:47 +0400
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD5CBB8A-2829-4436-9DA0-D1A88D594E92@gmail.com>
References: <20251201090336.1157193-1-christianshewitt@gmail.com>
 <20251201103529.1874a869@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

> On 1 Dec 2025, at 10:35=E2=80=AFpm, Jakub Kicinski <kuba@kernel.org> =
wrote:
>=20
> On Mon,  1 Dec 2025 09:03:36 +0000 Christian Hewitt wrote:
>> The linux-firmware repo moved mt7601u.bin from the root folder to
>> the mediatek sub-folder some time ago, but not all distros create
>> symlinks to the old location the driver checks. Update the driver
>> to check for firmware in both old and new locations.
>=20
> IDK.. 2.5 years ago.. how long is too long to wait for the distros=20
> to update their linux-firmware?


If compatibility with older firmware locations is no longer a concern =
the
previous patch submitted by Daniel is valid. If compatibility is =
desirable
this patch is valid. I=E2=80=99m not fussed which one gets merged, as =
long as
one of them is so the distro I maintain doesn=E2=80=99t need to patch =
the driver
to use the =E2=80=9Cnew=E2=80=9D location (our buildsystem doesn=E2=80=99t=
 process WHENCE
which adds a symlink back to the old location the driver still uses).

Christian=

