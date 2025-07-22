Return-Path: <linux-wireless+bounces-25849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C43AB0D816
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360AE1893425
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D38F40;
	Tue, 22 Jul 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJIqqvWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A2288524
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183408; cv=none; b=sh6O8ddYXHCsi8oLGQgsrsUgK49RAkLJkUV/s7JKfE1ZoU1qavj7rF4UldObnw7vDeBtEmPZRjbhqWqPTos/P4sJiL2S8HKndcqkF7ESMWaFvVzGjaQdgL6yhH6DPShL9nmVNXbDTABSYa58B1/fAqT3gIGcFoNb06jP03nRtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183408; c=relaxed/simple;
	bh=RLZzGvv0fQvrHgNWi5MsZ17U0rjJzPXea+WLq40MRPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUzDl2BFsTnjftm/Qk4Gj9zjXEI6TjgB7Rjk476N7RcWUHjoys4gbqE6vJ0HwMcW50Jf3WZ72R7KRAtvYS9f0uKbW97C4DHzQj4hGDRIiRIM3sfFTGAus1TUUCPwwCOp5l1gYwKy0RHr6fjaTJ3nRAHW03IJLOr84xCX6ozbaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJIqqvWn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a582e09144so2888082f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753183405; x=1753788205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW3XO8zEZYz1xD0qqvNEDPED5BeRO4482LcQqtM9mSA=;
        b=VJIqqvWnwAY3fNIrJugYbDDaAeLd06Tx5Im7aSbZc8i9s6JsNXPk+/rcmLAsq990c4
         A6CHVkDMrXTlMGPN4p6IFPGtR1bo/K98BdoqtsgoR7saprfpXh176Ke52cF9YQsLFDag
         YpM756hEAoWIH00RTKnKKzTIHT2uPEZJIhiZ7/YCwju+DlEMOHtSadu4ko8JVuO5dkn2
         KSufidHgL17ry0sAAAQSDS+c1kd7Caqqqh8hXW/3qbjXR4vpXgIUHakczO4dEoqpu4fw
         bemuy2ru/+53263aXpujzGUZLTf9eopSf4n9OswPGk2//Dy/duqYgnB1baI38HIAk2Go
         B+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753183405; x=1753788205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW3XO8zEZYz1xD0qqvNEDPED5BeRO4482LcQqtM9mSA=;
        b=okdjRb8Z5vbP6t7tlrnEf0iHovcT032QXRPg63SfFV0HKo4IzDDZoZCCQyv485QacU
         fKHAz8dIUUS98C0/HM3/3rSTYGE56OB/zt1IW2prs9WbHhyt1K4sCQGJtxgGUTRVuW1R
         z9xALOU+Z7SxYNpLOHRDkMPYi+HhIQL828KWo861m5q6mCSbAkF8MDJgvitGGkUcI4aM
         GuO3AEgkxvdmsrtUGEy4HdAdpvdBjiV1VQFThs9VlaJ2X7zKOxS96GP8XarkWt6cEdFX
         DuI3RRKLs0xTwxI+5TV1n5jXgXh/3CzQcqNH31xyKrj4dUwAPDAsu/Gb+CGwEZA3KbSm
         9a9w==
X-Forwarded-Encrypted: i=1; AJvYcCXp09VZUOh8vMgLWTmfGk4zXsO0a6IW8fdzcaAsESigtXPIX53obAPtSA4398RGAYpTfVgFLrjhY9wv4JpFAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iyagqA8rfoLPMk9sWtNJYguHyukKw70lq/gnK9ed8nnIIidz
	i0E0Ul91a/fCw+H+3Wfg4KMjZU80dp7kvCaIr0xFTzHq73IU6Ssr2kCuFF4VeOtd
X-Gm-Gg: ASbGncvbujj0uAYYKIl0MhilPMh4jYGsDvKNtHPyHl0yAZujgxGCkMuKFdaxVOhqzuS
	3W7Sc0HGe2qa6v42jF7FXVTGJHI/XgRsws97wt2R7hsSBSNNAOqdccvXjCmgFgVXnMyRr7+L1sm
	PhEsNOPwIa5QduXgTmrt4s/Q/U14fgxfMJ/x4lsY9hgqHkLaHsnJYrnrxPtO7UyFbGzyYky826H
	AfUCHw7iPd87OxRMqqJjxcHO4fmfSjMXyPa3pXSfLzVy11CzGg9ULBG6dD22bnvf3W1vDj8gbUI
	/0W7XbPfiHMpZHUoW5Y/Xyxj0sCHolE1I+yJvqt3CaRAo0ZmEvfw1m9fsGTlzisxjVJvoihwAsW
	iHMVV3V4vQYY/q0s7HDGulP38Tb1UOcY=
X-Google-Smtp-Source: AGHT+IEfDiD9I2pNF0jXJ/cSaeYSBpm9oX9sVP4lvivTI5awLgFLeYjfeutIkqKpvFemvrkgk5+rmQ==
X-Received: by 2002:a05:6000:144b:b0:3b5:dfc2:f0ca with SMTP id ffacd0b85a97d-3b60e53ea17mr19047283f8f.40.1753183404824;
        Tue, 22 Jul 2025 04:23:24 -0700 (PDT)
Received: from debian.local ([81.78.104.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b803sm12825212f8f.19.2025.07.22.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:23:24 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:23:22 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi: suspend failure, bisected
Message-ID: <aH90qhWMlUF2sgZi@debian.local>
References: <aDsNn70jcX6sDLLT@debian.local>
 <20250716185057.GA2548435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716185057.GA2548435@bhelgaas>

On Wed, Jul 16, 2025 at 01:50:57PM -0500, Bjorn Helgaas wrote:
> On Sat, May 31, 2025 at 03:09:35PM +0100, Chris Bainbridge wrote:
> > Hi,
> > 
> > There is a recently introduced iwlwifi regression on suspend. It appears
> > the bisected commit was only supposed to fix a warning, but reverting
> > the commit (with a small change for revert conflict) does fix the error.
> > 
> > 7438843df8cf7a484303caee7540a00f0ef972b2 is the first bad commit
> > Gustavo A. R. Silva <gustavoars@kernel.org>commit 7438843df8cf7a484303caee7540a00f0ef972b2
> > Author: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Date:   Wed Mar 26 18:04:02 2025 -0600
> > 
> >     wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning
> 
> https://git.kernel.org/linus/264c844abb29 ("wifi: iwlwifi: mvm: fix
> assert on suspend") appeared in v6.16-rc1 and includes a Fixes: tag
> for 7438843df8cf.
> 
> 264c844abb29 is not exactly the same as the patch Miri posted at
> https://lore.kernel.org/r/DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com,
> but maybe it still fixes this regression?
> 
> If so, can somebody send the appropriate regzbot fix command to remove
> this regression from the tracker
> (https://linux-regtracking.leemhuis.info/regzbot/mainline/)?
> 
> (See https://linux-regtracking.leemhuis.info/about/#tldr)
> 
> I feel like I might be missing something because there are several
> regressions in the tracker that *look* like they should have been
> resolved months ago.
> 
> Bjorn

#regzbot fix: 264c844abb29

