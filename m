Return-Path: <linux-wireless+bounces-8762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09990265B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 18:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5509F28256D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234114387C;
	Mon, 10 Jun 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yF0q0y1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB80143864
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035962; cv=none; b=I3n8aEW67FQvUrcdYf6GeHpZ5NJe+DbLtNN49CXN2RjTvgpqNpNwDamS7AmmJmSfjcfPoSmxWoD7FgPmWGCzMESekaQOGWKTPblz5iJeuLb6TFec7vUL6p6ctUPps504krRHeZjNAQvmoCwdvYiPqoQu9kcF+TOTH2YNQCJB5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035962; c=relaxed/simple;
	bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyNeb6cCzRL3rh+gnGLQOd8u63h2/HRJeIPrYWMyaqpLC8fC4F3TCxs3p2Jg1pCVZCjXJNh6Jic1xNmpd+Q26O0aia2ExddspWmt7hkPH+u1HaYqUYjs81nJ3sLEg9IW6uueF6zkYCmIknMOqEUnERkgrF7vJUD84Hag0NiDGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yF0q0y1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a3652a732fso562316d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718035960; x=1718640760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=1yF0q0y1eCoQOpqh90RhFohh2juKbCbuDZjgiZs9Y9bZDwhAbEzVLkDClBEHoW6+Mk
         1jW8l7Do1989NFTuLpbGoz7H1QKALA/VtclKbbZRYEFyg2IKmZtlASKwkBFJ0ZhNqZvQ
         1HlP871cztjrWI+cRlsK0s7bszXyO5Unjiwi1kMcKJXV4VXtEG5K9vvTfylmiHrgNKaI
         7WI023lCZ023l5kmvQu7Ku6tTJ/Slepa7NIwDDisLkeaSRHZsvexQZtmj2VbcvhYZzqj
         BLia85XT8sf6LScvV1fNZTCGXflA2rck6dDOMaKCMpiytkyuGa17IQYasfzKTRtV0WAq
         EH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718035960; x=1718640760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=BPyqRnB/PPx89oyPcaaNw/r7fRFDWPbuxr5WjToX4oHmCGSe4RFk+v1faMXlLmCQhR
         RQ8dvBSVD5dElnnkXdRL/KtxyA18bz8txBAH/PZ+OZoKUhdy5TVVF6Lz3P6SiV/gUDD4
         zY2zwyt7yzfFFxvsdmPfCi3oWVM4IDUciGD0PxgIY9KOLFoUfIDlutA0sCy0qUqqXCE9
         pszL8asY3iEPtcyla4F7hZN9sOQ2Gu948jLq5NGClGtYKH5yF1wRXVW7BxMPb1K566nM
         /Nu45S4zRh4Yy6gLCT56Y14annEKWVpC+KxzY+wE6rwxbKQVEiz0oM9aGPOYRQ0v6w3d
         0/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4w5PBxOxCYy+UW3nNP6lOnziS96GzyB9SHaLJXlnPyLPUtWbEzPhh5DPE+jTAxE4PM3yAi1dBcUx9koSUcuvRDLw73q/hPvGO9xDIto=
X-Gm-Message-State: AOJu0YxnDUVSAcev+hnzyY5SLivlpT24dBiFVhkPgP32t2aCFACA/rk0
	fcVTKQxJ5rdsDa4f66i0qCQOChXPWzENVKphYKLgI8rvqh/rmNJxD3y42W6cRMZ3o9Vlf3JuAaQ
	xPc86VF0Vu8ebSyMkfCxVmqmp9eLMDp3TfmQf
X-Google-Smtp-Source: AGHT+IE/aD6ZkBV1FswWsBDqg8wRi/7F2WLAtCMkHqq3t8Fa1Oct3M1hrEosflrAPoOwmBRuAeSAaP3oUTyhMdZeir0=
X-Received: by 2002:a05:6214:5691:b0:6b0:86ab:fe98 with SMTP id
 6a1803df08f44-6b086ac0198mr11047746d6.64.1718035959939; Mon, 10 Jun 2024
 09:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523112131.31437-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240523112131.31437-1-mingyen.hsieh@mediatek.com>
From: David Ruth <druth@google.com>
Date: Mon, 10 Jun 2024 12:12:02 -0400
Message-ID: <CAKHmtrTo0OpsmeEcjOgZ40y_H_unxsYCU_Ym9Oc9Ut+gQgUCew@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt792x: fix scheduler interference in drv
 own process
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Michael Lo <michael.lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>

