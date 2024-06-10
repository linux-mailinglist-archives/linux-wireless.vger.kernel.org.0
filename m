Return-Path: <linux-wireless+bounces-8763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8C90266D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B50F1C206FD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFFF84DE0;
	Mon, 10 Jun 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJ+7LyX0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B01DFF7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036259; cv=none; b=XOnEkdYXIDuT7NtKrq9ZuySViyEycZUzOMrjwzSC6SpS3UrPAPmOyNFzfSZPx0RUY8gglzNWLXQNvZnADLxmEsioCMEoU9snLhH0w/sMphpeeK0lxU0qBx7jbeY6or0C1d5ZfiTAlye+BmPx4Jl3M+eTjdROQPwo3lDw8zNQ6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036259; c=relaxed/simple;
	bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggNsc1SAYpTSXgKAoYRj1u68JL9SWx8S/FEDm0crWTO42suVBReZk/COTv6+eD8pEl9So4nIQoqnmluDsfUtwX2WHNImZ3bzi15DbKlJjTAl7GHmChFgPSsduWT4/RkjPG8g+V2igicmcOha/Vym5f0OOEzi9dZoYWV18whR+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJ+7LyX0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df771b6cc9cso46271276.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718036257; x=1718641057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=TJ+7LyX0UbVNtKKTqIdZXpCVYeOvTx+4ifYd5lVVfNkUDcKLBg7sEsJuRNt5tFgmUS
         3cl8DXzh48N/GY3DRkkj4/Frvvmd+p+5bO9q3Zg9Bd9jE3OykJdwuVIOJSu1/naDedEv
         UwJHp0I8D9hlZ+OqqE3b3AkWQq4pKIq/ToyAinQGVeQ9kUVEmQEDA7wNd3d4i6KmeO4t
         cVAtvQBcqa871rJvZQ4NcGGUn1vNEaKw9vnf/8NYcizmgDUARXHiUnVzMQGiDoBKfL1V
         HtDHI9dOYFznt6VTtSsI9FcWCCB1inznjf/gPLwWkBU/g8/DvuExfyr5wWUgd+tDtj2X
         5vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036257; x=1718641057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=T5Nmgpyn45GiVTzedvnGacnzSXHY6VWe0WrycXDCbeBPFbkuRpwc8SBMMfdg9uX5i3
         M2qfBIgTL7VdoIOEXW8iMU8Wc6VX+4KKpLAcXkDMdoYyqW2bGRiSqQTuqrtioAOAbudY
         Md8sVilb8c2j44faSzdg+D2FO3Q+U8zmpLONdQGIEjHJBWmzWsPy6qzxeP39PRlJtYmi
         zTL8ZMdaMlPs7O9E1WqtXj/gSPOSOEiryuR42OMkUWanbaoWqEFs8jDiLCk+D7OxdDBY
         qyeTKMa90F4zFZJL370ny85hwUXznJjAeyNfbhvEk7+z4KXnarX/+LYSw5gy7ym3Y/Hg
         A0xA==
X-Forwarded-Encrypted: i=1; AJvYcCU2MajBtw+jDod//cFSTwn6MulAQXWb9yJZa25IS2KtSaxmMyghtDLV8wV8JZtQjaOpVQF374fuCzzccs4VPyblcPZ9m72BwUjZZADdSKI=
X-Gm-Message-State: AOJu0YxHjBMz8pAnOiPXnSEJKekDQNR+PkLciHV2Sflu48Hkif9lTXuO
	i6hlsoWlOD7Xfq8ZyXRu22u1s78BiwJbtl4g/dFmHXuJ+cly3tTTwDxUW84sQsggq+Ba2bE7G/0
	gFn2U6mvp/WAxLVGuWf8g25Bg/PWhKfWwK6VQ
X-Google-Smtp-Source: AGHT+IGHJhDjrNJNxMp3w5oXGpyMNhws5k+6BrcXAVGbf0Vl2CbGh3uFcZ7sKIzHCofvwFIyh6Vw241h/NO5im+uDIE=
X-Received: by 2002:a25:6b0e:0:b0:dfa:e130:3144 with SMTP id
 3f1490d57ef6-dfaf652cda7mr10333881276.17.1718036256629; Mon, 10 Jun 2024
 09:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
From: David Ruth <druth@google.com>
Date: Mon, 10 Jun 2024 12:16:59 -0400
Message-ID: <CAKHmtrQRQPNJ9vcvD0GFVWL10iAvjaUnbgVZa01p+BgRHreq2w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>

