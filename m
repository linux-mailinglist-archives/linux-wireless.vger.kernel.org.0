Return-Path: <linux-wireless+bounces-13877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02B999CE9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6392859DB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B61C1ABE;
	Fri, 11 Oct 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqtNFYqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599D1F4FC2
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629124; cv=none; b=JMMj39EMk8zI36qgrc7QJF/5QT0SnZjHdX5y34VYB1H/t/sHEeVhNwdigygY77VDV0vtEwyt4DY821ll8MLQa99y7uuH1C2dZJduayUJ0EVQ/u/UIGCu+woGSSF4idv7f6Kd011BtufYjVQ5XzsEDx2uDUUkDNIbYzrcqOiSsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629124; c=relaxed/simple;
	bh=2UB1WHyYk1VRXvMkemn0ipM7tyuHFEAEYTEekHxJypE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sg4CoNZ6kuC7T3ENSjyUzYqtPnIPafw/XZa4YOOwO2AxQw9X0VPROOzR/EF2WzM594jU4Q5Kp3nvuB/x5MKNydXQnYerYVaz5aP0k8lyxS5YIMBpnQ1Royf6l+Qxu7eHh7L+jFtAmf/w+na1PHPxo+k2IjqYsfEMfIo/bTDq+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqtNFYqF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad784e304so18738771fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629121; x=1729233921; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2UB1WHyYk1VRXvMkemn0ipM7tyuHFEAEYTEekHxJypE=;
        b=IqtNFYqF1FuoTnyfdrut/QuLoTZzTg1gcbOb7n9hj4oLLFaEKqe0JbCB8pc9EvCQSB
         ytig2M9481ECch5iUpOgbOYiX8INlzChgaDysxIBnZiGxW4Dlqf+uJPMS3pCJCzJFTEQ
         wlXLahEFFo0zyKlQjnYYbL9BFnAcA+Q6DAGInp8EhrU15uB2pnRwNY7OK2Yb6b3Lhp3u
         KLWgdeA+0JsZc12lCCmgwDzwyd9/HWD6FP39PrE0feUcESyhKqfNo+3JYnpshlvogcap
         eVyx6JYqde3C0m2FHeCmPuPF0oUmpk5bxoUMy0wRq15urQktkHOBhRtRFohhfyVBHn9R
         CMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629121; x=1729233921;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UB1WHyYk1VRXvMkemn0ipM7tyuHFEAEYTEekHxJypE=;
        b=enw3bl7lUPKxuIM+Swj/l19Tz5ZLyau6rdPiU3XBEwRMqCOcl8ECSCrdhRM1lOzT2E
         oplUz4xVIbTaRXPJXlDvGzG2QrhI19c7aBn5krDZsG3f406bRXXrzgh6cRX+Q1/+yi/T
         ZSm/4v7OV2PcJ/e+It3LWmylTuyUKEeYtoAbgDaXfBthMWQV3ueJ8o+w01NAB76+OlTe
         iA8uTHoEuUC5T7AJKMzldE5yjziAv9thg3eeVJVtnGBD7+rEdpcpKyrTfqKzTQj2ObUi
         16412ruBzrdHHyv1BhCDxxpnI/u0cpb9SnYGGvMHMxv3j71IWGanfDD2GmEUdhvYQoZs
         rjpA==
X-Gm-Message-State: AOJu0YzMKNmqk1eGeq4sLHuqu7i+xQDDhlWvgq1FXT9xYnfXWNGui8BX
	hop3hUU77Ds7/BA1juFFG9pdSGr8OJOVbg8iS6+6TzNEhTumAiYuucB4JLJ5UgQhMg==
X-Google-Smtp-Source: AGHT+IGb4Qwz5fDPGw8TC997ZMvGGDKFB7Qx0S8BKn7pZV8THW4D6peSye0r8cTTXWENuZO7Jl/U2Q==
X-Received: by 2002:a05:6512:31c5:b0:539:9155:e8b8 with SMTP id 2adb3069b0e04-539da3b2309mr823211e87.6.1728629120586;
        Thu, 10 Oct 2024 23:45:20 -0700 (PDT)
Received: from [192.168.50.84] ([193.22.231.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c85b8sm511573e87.85.2024.10.10.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:45:19 -0700 (PDT)
Message-ID: <ab931eaea64e65d1655c8bfd95ffddf32d78ca57.camel@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "lvc-project@linuxtesting.org"
	 <lvc-project@linuxtesting.org>, Dmitry Antipov <dmantipov@yandex.ru>
Date: Fri, 11 Oct 2024 09:45:18 +0300
In-Reply-To: <9c83fca1a28c4b3f8fb2ca65752ad655@realtek.com>
References: <20240820055244.128644-1-d.kandybka@gmail.com>
	 <2c5c0d485df7b334ea0bfbb87325a5fbc7b52663.camel@gmail.com>
	 <9c83fca1a28c4b3f8fb2ca65752ad655@realtek.com>
Disposition-Notification-To: d.kandybka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 00:26 +0000, Ping-Ke Shih wrote:
>=20
> > This is kindly reminder. Could you pay some attention to this patch and
> > clarify if the rf4ce is actual for this moment and future?
>=20
> Yes. Our coex developers want to keep this chunk. For me, this kind of
> cleanup
> patch is not very help to driver, but I and developers need much time to
> confirm and judge if we keep or remove them, so I would want to ignore
> this
> kind of patches...=20
>=20
>=20
Thanks for you clarification. Have a good work on driver.

