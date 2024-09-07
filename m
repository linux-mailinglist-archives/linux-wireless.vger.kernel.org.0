Return-Path: <linux-wireless+bounces-12627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7C97042A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 23:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C5A1F22174
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F339149011;
	Sat,  7 Sep 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3HNyiVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6D12FB34
	for <linux-wireless@vger.kernel.org>; Sat,  7 Sep 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725744124; cv=none; b=bfSeDtuqiNbz73S0wEJ0Wys1ip+xwKXehiw/vXwd8aLVmq9Z78NF63mxMEgdZFtqsyhfoz0TTjJhNub/TbS0RWDf39V4MDwwOLMvJK8ebXczMWqMnriq4LYEYhy3ded2g1yrqC1qNQ4jejEs7Yg5AdMFlxKUdg9atBLjtPxpBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725744124; c=relaxed/simple;
	bh=rYyEymuvNhxzoIXG8LkUOxc/C3U6XGarXeT9/bq3h9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf13R7a+w3unL7BYtCHj4XuZK+FEAVi8vrLrc0K27OOI2h6LfHeUurY8qnpX24jefIV5+DgMlP97LUxgktL9qcJ9dZK4E2FLFof19MqAKlVA0Q9V6YqsEaIKTtlTeX9dHuQOLAtLpimU6EU59/apLwKqwNJG3/g/xLiMRg1ULho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3HNyiVd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d9f0cf5ae3so36805517b3.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2024 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725744122; x=1726348922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYyEymuvNhxzoIXG8LkUOxc/C3U6XGarXeT9/bq3h9w=;
        b=i3HNyiVdcIV0Ha8iU00xc/my1vCfbTqzqYdGs4DWG69uTWCd5wbdXQZobh5FJO/2Lm
         tLboheURDhyTB40kjWcZKlu/KUIUv69TOw6JtaLmRAQgT4fFkzIivZwq/wC/EIdijfjd
         Jk4QG+argILi1n7U0ylcmSpPbWkBMRKcgxXtZUTlFWvS/rJXoodHU2hpdVRp/UWL4Lq6
         zQ3UMVVnz5TaSYL9jwJikZtmlU1EpOErUrjNSacTh3F/Vs7LO0AEnJjh3cTrI3qohIyl
         SorVxFro85HAQUH8+mdhDQroGWALUn8KwWGmgkuNeV/eDJiAn31ePBMOEVD0oyTAPLkt
         HimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725744122; x=1726348922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYyEymuvNhxzoIXG8LkUOxc/C3U6XGarXeT9/bq3h9w=;
        b=aCM0h5g0IsBMmraOl6mEN26wkahN/HhpdrsoAW86EK49VQjXGpO+P33MQiy0UBpT0O
         nAZUxpmKxS1xC/ZN8erj/l6mAFAvHNZbsAMK/eVilPiXaw6iwFQVeAujESMaJD408J9i
         A2ldaCp+6EkuM6IiZYnAAPQavoOhEjeZfMJfBedC86qB24LaVhQKPP37qwNu6/dTXa+w
         +wPeg94V+xxMHF438A0r/lbegGy0qrFm07yKEinU1EAxzAHfdp3mR+1b0E77d40UEnx6
         osOmOQtqnE6ZjkfW+mr3I91XJf7ou1feGsdEsttEWebHc1blu/yQlkVZWie+6yCJOvh+
         UWyQ==
X-Gm-Message-State: AOJu0YzKEmW2SGR+ovqPIU1rvDWcpnQRdeu2IpxgC082BdMYZsi5p+3p
	+LB9Vl8ZOZ6UkBN/bSvjGddZiPxBEqsxzndKx4j0euL50/sPIX5xdasxSUSwSWYWmy+dgR89MIz
	t26boMK52eXYu7dxVFOTxHfFHyag=
X-Google-Smtp-Source: AGHT+IHUa8z8wC9gMZICvjOxpo5k2J0k/3mJeJ6bkd8A4EpAKfn+G6f+65juWLeZWnUr36X3mtmPC2Qb7DR3sgdwG1o=
X-Received: by 2002:a05:690c:dc5:b0:62f:a250:632b with SMTP id
 00721157ae682-6db44d62e57mr76625697b3.8.1725744121963; Sat, 07 Sep 2024
 14:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
In-Reply-To: <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Sat, 7 Sep 2024 22:21:51 +0100
Message-ID: <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Sept 2024 at 19:35, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> Can you please try to add:
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=094513f8a2fbddee51b055d8035f995551f98fce
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=cb347bd29d0d106213a0cf4f86b72dffd08d3454
>
> and let me know if things work again for you?

Both of those patches are already in v6.11-rc6 (which has the error).

> BTW - I assume that your system is configured not to power the WLAN device if the power cord is not
> connected and the system is suspended?

This is a HP laptop with default BIOS settings. It's possible that the
HP BIOS turns off the wifi when suspended on battery power, but I
haven't explicitly configured anything related to WLAN power (I don't
see any BIOS settings for that), and the kernel is running with
default parameters.

