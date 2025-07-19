Return-Path: <linux-wireless+bounces-25684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDAB0B176
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 20:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD71F1897936
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19172610;
	Sat, 19 Jul 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvXU3Fjl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E721EB3D;
	Sat, 19 Jul 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950291; cv=none; b=Jk9hnmATjrUxTqHkjaMpnCkKLtDjzyrUUcFPPCtFas2UvE+X0zFmlvodj/VpsS70JQplniILSYuQzRhbYYsLzFnL1pdrr28vX67m8eJBExZo1j2AlLQToWgKS+cchPRYg/V9lnTFKiOVFRqIhgaWFAvqhLQzYA/hJsdHWRwSc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950291; c=relaxed/simple;
	bh=e0fIJnWzyKIkigChJGyFFUHzeIg+IxZGanqGe8fTimo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fae6kHTHJSuT5Mm/94RadhMMtdfs2rOhKm3XYPW31kU1qgDG/EkLWrYxlo20IOTNBebGAJqBiF7eBt08Gu25dNWURWvoEvSOfmqr6K1koTSxMGMuTrm3iika/76ub+p79Tt8eAu2Zi8vS5j5TFGBKrTHXYxpL9YQ1RvYu8ZMnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvXU3Fjl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab8403b6daso32775881cf.2;
        Sat, 19 Jul 2025 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752950289; x=1753555089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl59C4GeZmc27Uq7dkQuVOyvhcWeHD2FRxPp5t1oZ9s=;
        b=OvXU3FjltiLbgURKadpcrF+xRQRvIQptAGUQzhVpi9AU1D4Yjmqcj3sOtwTqo/9JY2
         J/bZjbG+5nHtY9it342MhWtlH9vszNUXx1iUx0NSgVu+WHXDf5lDDfQ4ebl1MaJQtTpQ
         Sq3SI1m9Wil7dxCzNuPx+MEUMIOzHDwFr5cQovJAz8ACqblJZKK4DbQKIzGeFiC8D2d7
         OZRPglRzjwCKhiqKHCwI6Isw+lygl3TwxbpWtXygIfyrxJYug4c0y4a6ksLdRVfcKQh/
         I/j/os0fDT7gA/qIpckwyXlQcYy5IOp1+dJbvm3eNw4hLm4SLp+cPzwYKDOfTnv9Zb4a
         21Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752950289; x=1753555089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl59C4GeZmc27Uq7dkQuVOyvhcWeHD2FRxPp5t1oZ9s=;
        b=FUZKLDKGBYlEL+Ea54eLpRUWbIg50PFr09z9JSocRt822EifU1DKCt+2M7CGKSfWKs
         gTZoqWXOgV7ab5wc0qJ4J1/pvToMOu9mmh/4QWBGndPkAO9wg6kdhtkK0f73oYSefq/M
         XDldN4r1k9O9IVzpnW2tHfDQXpUEMjropx+fz1Ku+LJpmIeu+H3DjEBkzhrN46dGI6rD
         e1qCZJvMgN5cji115/8piviuWT4oOkPrwzzHqfJimcuIswA+WvVP1Qwt9uEBRiOSrU4k
         HERL9ldJOOJYcrivSZQthdjf04fMJAk+U2wqUBQ3dto6Prp1YKWT6p6vxziLKq/yHQq2
         ZEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFYRm0U/AtpSun4791ZQXiatZwHHcmnevarEpWAYtBlv25Rep5CCqJ/nG4pjIe6VbV3+Ko2tIkJo8RIjKeUfQ=@vger.kernel.org, AJvYcCXHkHwCLlKJtUnzuMfHeSa/Z04X3wQHqB0U9zsXS0ibGS1q/g0akfV0UkEGaJkk7E35A2D21kzoqJkSJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxsi3yRT6hQeJbBioDbXU9zUvXkiy0lqO1w63+Pk5314ZgaTb
	NF2P6+zco8RV/jXvjDwmu75OtSy5dc5wH5Bdl5qzchdK2vzMQEd+Uk5y3SreWD9w
X-Gm-Gg: ASbGncsoykQcYU1VHCJeGH/aBy7UFSqr0wBKtWeUQAEoJorhMLYRWMpTo1zt2UpxV+N
	K+9KODsZYgyYMw620fC4Mk7IRTSSETS5XYdKFVnCpja5xY5DF7Rk5+C/fABzCNrGBYk30Fe2KiV
	Qcapwis3rieW6DS/IV1hDyGZrdRlPwuaAsI8WEH7fxB6t16jt9NGxM8l3BI+ZweBJ2rL8I2+D+e
	e2tE3xNmmDmTpJFUu4Y5EOymy0ChcONcMtwBafPq7SckZw17PZg1rginkulCGoqgDMGsh9XTuci
	uN9vsYapFCsMmW9bmFPI1XffcnWKeCBOQ099K9+iPzpXj63NHxYmtHpktCnGPfiQcLOdD7mhQyC
	FWtPM3XBacw1V
X-Google-Smtp-Source: AGHT+IFRJkagt9nzAyOqwe1iSpk+o1UngMElTbIW8vXx9uVIUaHZNNUT7RZAmsUBTogbTuWdSIk6MA==
X-Received: by 2002:ac8:574a:0:b0:4ab:60a1:2eff with SMTP id d75a77b69052e-4ab93c52158mr172271671cf.9.1752950288711;
        Sat, 19 Jul 2025 11:38:08 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4aecf52sm21616231cf.45.2025.07.19.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 11:38:08 -0700 (PDT)
Date: Sat, 19 Jul 2025 19:38:05 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bcma: Use managed APIs
Message-ID: <aHvmDZjmhxG3EJg9@pc>
References: <aHvFi5PMXFxGwd1W@pc>
 <1cb5c9e8-9894-43e6-ba3b-755a7d1dd56b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb5c9e8-9894-43e6-ba3b-755a7d1dd56b@oss.qualcomm.com>

On Sat, Jul 19, 2025 at 10:21:59AM -0700, Jeff Johnson wrote:
> 
> 1) When you post a new version of a patch, please do NOT have it be
> In-Reply-To any previous messages. Each version of a patch should start a
> separate e-mail thread. The guidance at
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers>
> seems outdated.
> 
> 2) Most maintainers will not accept patches which make such a big semantic
> change without actually testing the change on hardware.

Thanx for information

Best regards,
Salah Triki

