Return-Path: <linux-wireless+bounces-20742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC54A6D556
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA5B18864D1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2D25744F;
	Mon, 24 Mar 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNjgYoIo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C525742D
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802217; cv=none; b=u5crcrxWabDVNkObhYxfxlqarHPDvsrZ3cpwtcEqKBnsnhi+lVEjg3q8RfKDpwnnS57LoX9FjGcyQfXxp9hxKZHVCTBI1ZTRfeIppTjRZstx06cvF+g2L6ozEnOkKkm2usIUOi1zouB3nE2AQu5xlqY8/g1mSgEZEZlzR/76WOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802217; c=relaxed/simple;
	bh=Wja2HIkcCc/qn+fhg7yuV0A96iCH9nSXOnTIZdyzsNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyfaqQb2cbWh+gz4zrOxERnoonCkuJjWa0sxWrDCTln5m9IYVYu4vdzzWermp128lBs12p+nVdHrysNpKwxSc4N4Q4K+547murt8QR/XIM9vlOENfs4AL1zb2MixMjYA2oMWs57QNLb79ERpLjXiwTs93icf0NIPtUJTiSCgF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNjgYoIo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so27173275e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802214; x=1743407014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENeTUflag0l1WgJ9MraeaFTIx2U/M6/MceOO9Gs6H40=;
        b=TNjgYoIoyymn/4+AglCvAOvp4FaS/0FG8fA9O9PbdR/7fN9vrgyJjmc/SPY3lV8xlr
         8/joueCTVzHixOvZN6frHL4ivVU/SsOsdNrawpEFsfFJX8Ye8aa8whkthKUs7mLen5w7
         /mdFYAc64y6rOx7U4HGM27lvHLIqdGhs1KN61LnUwG7/Iil9yo7MSDHqhru4CPTbSyxm
         RpZs9KA1TUh9A4GU1yGOuOJpeW7Myd7x4gsr/5+lo1M29K44IQgunwSBxZL1x3ZTX9wX
         Qv7ykq1CMHn/DbwsVw006bHR3pW2kLj131sRb06ODHwzJRUyO15uRXw3eHQFKCLX66Fe
         mOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802214; x=1743407014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENeTUflag0l1WgJ9MraeaFTIx2U/M6/MceOO9Gs6H40=;
        b=nThn+NFjSHv0WR45HRDWA9uurv2YW0Hh4mfMdo92qgNyTpmqWQ9BaJDB3M8GpZL8HW
         D6GKbsUBZWd9eb6C9EKwTbRk17D3blNQfnIgvi/7Aq2tNWn3UPDu0AnqRqsZLN3aYiUg
         mEKBYuzJDCO8L8WEqaVL8X82rx26HFrKA4xtQlhGX055ixVjw91VgL3NAYbBs/4rZYtx
         VTsDqU5HVMMu8pBPR3KZk0p4QX2bWyPYOsJz9giInKGw1uZma3duTTWT3Nm4We5Ti94p
         xIMHAbX8dHR7Vbh9g7mo3pJ4nQbwIT6fUsMU3FY3idn8wzt3tPxnx21M7ycZIw/zd5S8
         SxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhDACknoMFH3/mi6yodDddvQ7yVoYb5yi7D2CmeHYkJ1bPMQEZXaiRWkxbi5XLHVM+1kYx2WhWRRj59PQEWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXPnLrC72/XBi3fwomlavrXQA0uLdmoZK0RqoHyueaEf2Jqhf
	yfJvp2a7YHfCnUorcbLyxEKVmtGVfEz9u4xOgwHHBDxh5kRtBnnYYNYQLByXbLA=
X-Gm-Gg: ASbGncu3naxUARJ8LUCI4goLzzCx4FC+iuT4rVIDDltrNyCiHS+cbUV+Qjs0PzCXZuY
	jfa9hdoBhNJEL+NPqxuKR6ADO8QH3pHufToVgFAxMJqxFsyxX7W50wjgZjIms0+FhlB1scsnCgr
	BJyRzT+C/fdRhJ/eqEQdBCgxVdSowcH2y+X1Z3qrp9tvJERezJ9YNlj9P7GnGplcoPgit6HNEQa
	5Grmi3F4B7xTwXeCSVMS1E5hRdrPqHQy9giQLzt6pO9m/1D3bin1kdM85w4IndDxNQ7a3ioWXxZ
	DV8OfkjpnKMAr55l2HqYU90XJW8g6AaC07cuIz5a3B+Ofjlb/g==
X-Google-Smtp-Source: AGHT+IGmGmS5ufUfMSrgfk7DIRjiH+iIQAHj6POw/bNjEYZrqwMBfch1zIjXMn5LOd+CGNnKdNiELw==
X-Received: by 2002:a05:6000:2a2:b0:390:f400:2083 with SMTP id ffacd0b85a97d-3997f89a039mr9195803f8f.0.1742802214396;
        Mon, 24 Mar 2025 00:43:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9eff9asm10311692f8f.92.2025.03.24.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:43:33 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:43:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	James Dutton <james.dutton@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
Message-ID: <d723d5c1-ed17-41b8-9bc4-274fd8e2b615@stanley.mountain>
References: <20250322141910.4461-1-qasdev00@gmail.com>
 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
 <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
 <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
 <46a53498-6c20-48fd-b090-02163baefddd@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a53498-6c20-48fd-b090-02163baefddd@web.de>

On Mon, Mar 24, 2025 at 08:33:39AM +0100, Markus Elfring wrote:
> > Also the "phy" point will never be NULL so the check should be removed.
> How many tools can help to determine such a software aspect with
> inter-procedural analyses?
> 

You can just review the code.  There is only one caller.

Btw, it's fine to have unnecessary NULL checks so long as they're done
consistently.  Generally, we prefer people not add unnecessary code,
but if it makes you feel safer, most maintainers aren't going to nit-pick
you about it.  If you are doing the work then you get some say your own
code.

regards,
dan carpenter

