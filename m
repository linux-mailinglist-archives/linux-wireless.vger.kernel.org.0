Return-Path: <linux-wireless+bounces-26043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA32B1501E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1174E3A7C45
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25C1EF397;
	Tue, 29 Jul 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un/VKBoO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1D1F956
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802520; cv=none; b=rYoCJ2t+QMbNOykhkkNtY/E2OIPsKJZE4uQZTcy8KjzDjV6SAEFMtqX02YU98mVn2iE6vXhaEfJiCInbQ/hkfjN2fnnZj+A7VKevn8K2I9ub69bkzduN5EkpeJBXSsKT1ZgqsTlGbVxXhQUdYSJf9Qs9hXQ02thI+Jqn+3oZ36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802520; c=relaxed/simple;
	bh=xwIqT8dae6nKNdgzvc4/e0tGWL+Q+iccPdK30+Bg/2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NY8U2Q69nYVBR4TVeRLFYn9gokzTnH1FtAXjIBroO5cmIyQuNW7yHsPBvrt2RUX1KmU+QO5uyUcAbmhBe+sy40z01/i5QVV7gZOsSIPBx0HdSfssRTwk31T3af/pMgys0FX5s7LN2X0psKXU9fgkoNio3j2Ig9vQmp28oW1IK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un/VKBoO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9741403a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753802516; x=1754407316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwIqT8dae6nKNdgzvc4/e0tGWL+Q+iccPdK30+Bg/2s=;
        b=Un/VKBoO8l7TIMAmozRbziKzA3tCihFRTU1IMWlxOVEjRBgt+zXdFQharuv20UPaJY
         IVxgCFowEIby0bM5FVzIWg/tcwvKX90HnLX/saZPpgvXBJzlspU9s2Ejw7FurrelYrXS
         YcdTs3DGl5Ur1eMHmRdNUnA0h7P+5vJv4mnY6e1OrwB8s3G90j9bcr5IWPrg8LAi2Zhv
         Es/Ta1SNUNsS16ReYocfImAXvhcac0jsf02Mwe6dINFhFuYCvATzudTTgIH5ODLqWIDv
         N3Tw3NsIHNYmTk46OBOEN8fWScmDQ24AEXvDOUUD+sjAJfVh9WsreNrKEGSSO64EPbth
         PWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753802516; x=1754407316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwIqT8dae6nKNdgzvc4/e0tGWL+Q+iccPdK30+Bg/2s=;
        b=RjxNa8O0mxK0qHREQusMNzBvnZXyhxYhb6j/+InRAMNfkCp3xjvfgzAARmgCiP5aNy
         rdNzHEFPm5uc/z67i5HSXfBoE6BLi+0ccumpsmdO7DhCZbETQkkknaShkjHBacpoDg33
         Mv0z/GP8KZycWqQOpR5Jno3uw4P4hj0ZwlzoasPAvSwE8ZIDmvzB3m5dxcOJHzsdc8wW
         eD4qmynbmx6M8fjlv411XDPVobJoAKrJcDETZJJgSHUx3rnerCIDuw2ntEhvdzaNDkFI
         9qdPqQHyjSs6kNmRXv2TRi3dBmKOOdTsobqEVnOKLQz6nUSFrVdfu0EA3xBwZPuqP78z
         xxXg==
X-Gm-Message-State: AOJu0Yx6jvj3/nZ3IVj5YbNuCKRNHyY5HcthEJ2h7lAKtI7e2eKUMyAF
	VOCl83PaEEXzMM/qDGa20LaUwCSD1zoNJsAQz8dTbVtluOMhEl2+gPFsAouhvIWZTb/vl/Gbdm+
	qMSWsOAmIWptbxfnCh7BePNjkAp+T9kKRig==
X-Gm-Gg: ASbGncs16XyZ/aZHGXQHduulzXxhhllHLH/rgNJTOIVpQzTlaJCpJPVXGDANPdBRx/X
	SMMvcu4Os8YAky90kFsfkYgkQcoT6gVYjFGhb92lI7xGLf8crfFpTmIZAuzLaIX/lG1ZOcNgWK2
	JTXk7xoCA8qH4nvG7pvGxJE8mAsCUYGhyVKy63cHSL+O9mDID+EiU9QQnMMAfQGLWsG+w8x+Ca+
	Q1bTBCzVK+rWVVvbA==
X-Google-Smtp-Source: AGHT+IHtMHVG1yuo5WrHWknJSkh8/RaWI7h+PyOYFdaMTUDUyK461ffDCcmvy/OWgD/OAnUiDjn4V6aUKpYQX9nLZNw=
X-Received: by 2002:a05:6402:26cb:b0:615:4c9f:f7cd with SMTP id
 4fb4d7f45d1cf-6154ca005b9mr6559280a12.7.1753802516318; Tue, 29 Jul 2025
 08:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Castiel You <hujy652@gmail.com>
Date: Tue, 29 Jul 2025 23:21:45 +0800
X-Gm-Features: Ac12FXwCX_6MTWGR4X9xbcst7mxoD6yQ2g12kOm1VG5P6UAjZhxDlJ_OEgtR6hQ
Message-ID: <CAHGaMk-S4SZgcLczH1ntBvYJCk1vxJBfxzN_FSpGANC+-P0p1A@mail.gmail.com>
Subject: Question about flush_sta()
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a question about flush_sta() behaviour.
From reading iwlwifi which is the only driver implemented flush_sta(),
it looks similar to flush() with drop set to true.

Is it correct to assume flush_sta() acts more like drop?

Best regards,
Zhi-Jun You

