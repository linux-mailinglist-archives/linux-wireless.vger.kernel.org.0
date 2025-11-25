Return-Path: <linux-wireless+bounces-29307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A27C83408
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD643ACEF4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79102701B8;
	Tue, 25 Nov 2025 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Qe9bleKI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CA26F2B6
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041965; cv=none; b=SrX2z7RsDT4eu+5zcTaFYsnyfGFnnSxNnvSEfbuP4t1H7w0COfG/uWc0tdNX2HTTyJcG6vvLYYhLhdhGnzdwoUMgzW9c49qgI0XV5quvdKTTIpvHf2PWBvwvfXG555TqXf5dBSfruPjMqeEAao0yM7RsU61icdysqJS7YfIucsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041965; c=relaxed/simple;
	bh=AzuvWltXU2iR7F8fYMfzIuIHOzh6HjqBp9hNUDMBe7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLDikUxLSW9tv59uV+Fk9CDiJvCEbqzRLWVNCQfWncnhs6JfvmNsn2RaJ60/fMBtlF4cpxen0CheNuD0fJpoRygbl0CaajYUCPL2e1uTPaNb63Qu0yQVYhiNJBgym8OK/K1dXCfu6ltTBmxC58cQKy/myntgpA49jXmCf8qaAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Qe9bleKI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso5032243a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 19:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764041963; x=1764646763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DoDDizcvREMZCGmhouhNwiQ5IxgbpdcT6INRYNwCtqc=;
        b=Qe9bleKIeEDFWuEnrY81jxaZUNXl+PiggW2c+vbpRVlyocbuon2hfnhcfLR5fIeGAX
         TAH3HoRaYGPg7etAGQ0S/fpJ+PiWuRgUnVW5l6+l61Q7HnjPdMYXyeKUx944+NTBkHbs
         hUc2vWw69W7zEJS7HwoCTjWPC7nrS4pfTak1jErnaA5Nl/DzX33ZgqMRGZjiIUARNlpF
         zT+RTA+gN/Io0S9qYBh5v+x5JG3RJk48AF7BBrdC1Icwe6no77sNdmpRH6RVuVHX6iNr
         FwfLEWrBif27JaSOJUO8URe8IEQzzqmZrR4DxYNHLXJJ++/Bj2V2bYcJ3FfjFmMR/YGj
         DYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764041963; x=1764646763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoDDizcvREMZCGmhouhNwiQ5IxgbpdcT6INRYNwCtqc=;
        b=BAPa7Ia0j8hH+kuXZiZYD4/rT/YOUfInivWr/UJxvBnC7HNcBn2dtjgacLvCtee4Ml
         h46t7FXGeYkBcQmZd3m9nmcRcNj+i3hIPqCFZWvM3ZrSj5RXUmuh9buCj4GF0pUrbWuE
         bEudaItbRCnheNwdYZfInCPDLMaxHCosKiuncR3y1+wOacreu1ZfUcF0Jm2ifBSe7sf/
         sBv1R4KLaKYe9ORYzpnt6C2s/PunB6RcPMTMZdnAK+ZrG0QhMzObcajayrxBBFPYnY4z
         27X5Tn3NwoQhqpyvWaIdYigrAabxgeUzg5IAAiZROcNmdSOHDRYWzpZe4ssCSoigf6kR
         uEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFNg3xH6t83ICgGEFqizBCUnxr1XM5iTxyKAkfVDTqtDKrAKyzjt6DE2hFawB0BgE9c1QOL0dNUMraf97u8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlB7MDCm1RZdXggzIHHSno9oOPmu01PQfEWmSTapIGzrBL+cz
	wpupSSbSloh+XcN+/tbwMtTqjvrs5u2S2ahxF/kHym/85nQEbgK03bk8CBMEhwu5Iw==
X-Gm-Gg: ASbGnctFHTFjdNPOWhWa/k77pY81olOOnpkcY64UWoNTgD8RoR0vrzRqVFydzq+iogi
	iLONrThRm1YG7cupjmjOilkEgybW5bxIFWYn2tu+VjzmdSBm7022cDwPCVQtE88C+KRHUM9Qa4n
	2UI0kshHGEnYQDLRRAHX2dbLc2P+eFkZ91EEqw3Yj7Mnz8eZnz0bO+oMyD6MoCyPqe3nuxiHoPc
	0BXfmcE5v1VTldoiVxoDZEpLLhjp8cuoakYeu4CxwpP+yfzPPY27xnCz3hpBxfiXyc7exhoCxtx
	GRV8Vr7pCHza8Vz5Pon6CFE0wl7gU55SIvhbKQWhY+dM8tKwB2XwhXZlgNFDcLv4OaLxVOhnn/y
	Ms8o9QB9R+L0bDdOJCFIgX15Pg5YxwX91AF4FI3WaWMzhuyXN5+xSx75AmG5V6W0Gvyf9VIeSyR
	4K0ev0En25OuB+
X-Google-Smtp-Source: AGHT+IFcuniyBRG0aDQNuI8BUO7OZfekIdPteK19ZPxYjWNa2gJR5RzujzKyY+Q0twmg045t80RGLg==
X-Received: by 2002:a17:90b:57ef:b0:340:ff7d:c26 with SMTP id 98e67ed59e1d1-34733e6cabcmr14232385a91.16.1764041963014;
        Mon, 24 Nov 2025 19:39:23 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm14800611a91.8.2025.11.24.19.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 19:39:22 -0800 (PST)
Date: Tue, 25 Nov 2025 09:09:15 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com, pradeep.reddy@morsemicro.com,
	simon@morsemicro.com
Subject: Re: [PATCH v2] wifi: mac80211: correct FILS status codes
Message-ID: <20251125033915.3m2uczkde2nqcoya@1207>
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
 <20251124125637.3936154-1-ria.thomas@morsemicro.com>
 <29ebeb55-1528-42b0-a692-11f20097fca8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29ebeb55-1528-42b0-a692-11f20097fca8@oss.qualcomm.com>

On Mon, Nov 24, 2025 at 09:52:31AM -0800, Jeff Johnson wrote:
> On 11/24/2025 4:56 AM, Ria Thomas wrote:
> > The FILS status codes are set to 108/109, but the IEEE 802.11-2020
> 
> Note that the current version is IEEE Std 802.11-2024, and it would be useful
> to directly reference Table 9-80.
Thanks, I've noted that the current revision is 802.11-2024.I cited
802.11-2020 because it’s the first revision that defines these status
codes. I can switch to 802.11-2024 if that’s preferred.
> 
> This issue was pointed out by IEEE in "Errata to IEEE Std 802.11ai-2016." In
> addition to this issue, that errata also calls out renumbering the "Category
> values" in what was then Table 9-47, now Table 9-81, for FILS from 22 to 26.
> But the current enum ieee80211_category does not have an entry for FILS, so
> that part of the errata does not need to be applied
> 
> But while researching this I see the current category 22 enum is incorrect:
> 	WLAN_CATEGORY_S1G = 22,
> 
> since IEEE Std 802.11-2024, Table 9-81 has:
> 	22 Unprotected S1G
> 	23 S1G
> 
> So that might also need to be addressed by someone.
>
Sure, will review the changes and submit the patch separately as S1G related change.

