Return-Path: <linux-wireless+bounces-11307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F6194ECC0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249851C21930
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2A16DEBB;
	Mon, 12 Aug 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGyb4sI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2071E488
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465221; cv=none; b=MtZWz5DMybTaTQjJAzVHpfGnhKHSdZhgL+juqOhLaUjrkH8ckFgv1iwX2KBjMG30klTbV0B8sSt9D+FrxONN/FtKTJCo2iC0p5YfjFdAmAPpp6nAbDTwVh4CxYPUebyct0e7nqX3BQl2TDVxgHw3gLHvgkI3UusuwkWpYK/ZZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465221; c=relaxed/simple;
	bh=kq679JXFB637W1Tqu4I1bX+A6aIDNhhFQURQtdBO5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8Wk7QcFrfwm+ZFbe/We5B2QsQqaSfS5G5Zj8RLbRDZHr6f51R9nhzP0VUN93qkXH3vVjUdq5DNKVZ8I4BdD3YK2wX0dQ88ts65KY8C0kOzlZf0FlqI6tvBpN+BgWn/0c5HH22UEN8Q6Scug87ZTOOX1YiaqJyKzQkGtkG4i48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGyb4sI4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-699ac6dbf24so40261177b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723465219; x=1724070019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kq679JXFB637W1Tqu4I1bX+A6aIDNhhFQURQtdBO5n8=;
        b=YGyb4sI4uf05TWExEbBq2yWsLXF/Ytf/6r8UEs1uzC8D9IIQZ8Z0Pt5BYeIqTt7thR
         wEzXt4+GbAFNLU73v/WmqUU3WdwdClWYQtrPC0Kb0EAwKceXCqhqEWjogzwdBhZMsSMl
         0XhJb7XiRuTU2UaBo1RNFtFDEUrW9Zwnmgy6nxV9zR2WxBF8Bs+pwMh8xHaMj4KwDiCW
         4hhZ4U7bs8wWDrMoJkdC8cBmoNkTb98yq9Y0VNwufRoM0uAxp3SrQpFrJJNsS+zfpcZ7
         ZPNkSI7gHvrBfHI7PpVevi9RFn9dltaP5P6NA4m0KN1KuFqhV9fFXIP/Cqdd+bBEE348
         fi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723465219; x=1724070019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq679JXFB637W1Tqu4I1bX+A6aIDNhhFQURQtdBO5n8=;
        b=lkL1740ks7d8XEvhESLlcZRr2cd2LyZRSV/8CTsYY/KK+S+twHrd/D7Ymr/d3H6Uw8
         UCbjw8SIAdkD5w9d1If4M9iiygViG23uqIwrmLfXHZXkbUmsgcDXrCru6BS+m0KbxYOT
         hHVSfG7885bJKmOsEI6j25Ww5kYSzXoIFQar8ccly29QC3rkPbDv7GctGavZHLgOsMep
         7E+fMwpaqUdzUP9qKm3zYLV9zLvBrekLwhdH1MHzRcll694P9/pHoDMcpSN9EwgjRLxn
         EeGbf2Mwt/Xk6a3YU2H8gpCQJT95karbzH+TDhO2XwMF3gtPQzcgG6S0wpbTLi1Plu3a
         rttQ==
X-Gm-Message-State: AOJu0Ywl4xBr7t/IDaaN8Z+OFcoVYeZumOOvoU3fxk4MXCU4NhEIHNHm
	dTqkUfbULb3Gjioom0BOIZGUTH6Q5O9ViIvOnGLnrHB+06g0PggiZK5u+3vdAXeRagFAUVI/FLw
	TEuI/K5nPc/M8urzM2ks/qrMVG05wZKwO
X-Google-Smtp-Source: AGHT+IHoFBN/+scGNP7kMLSb+aFYncBccPyOI8lBlEngugp5xukhJsJHIQw6I+Ur9TP2C5RZZu3F4dqoOyQT+HCJCRM=
X-Received: by 2002:a05:690c:ed6:b0:669:e266:2c55 with SMTP id
 00721157ae682-6a971ade176mr2159407b3.5.1723465218646; Mon, 12 Aug 2024
 05:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812110640.460514-1-benjamin@sipsolutions.net>
In-Reply-To: <20240812110640.460514-1-benjamin@sipsolutions.net>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 12 Aug 2024 13:20:07 +0100
Message-ID: <CAP-bSRY+F=_zek7Y1mMftQJqmkTenc8_sg9J-GO=aaAcLVRvGw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: iwlwifi: correctly lookup DMA address in SG table
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, benjamin.berg@intel.com, 
	miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev, 
	johannes@sipsolutions.net, Kalle Valo <kvalo@kernel.org>, 
	Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 12:07, Benjamin Berg <benjamin@sipsolutions.net> wrote:
> [...]

Works for me.

Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

(btw Benjamin, did you see my other email? Subject "iwlwifi: WRT:
Invalid buffer destination".)

