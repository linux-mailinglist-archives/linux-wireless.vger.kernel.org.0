Return-Path: <linux-wireless+bounces-12963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD297BE13
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983051F21EF0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E71BB6B7;
	Wed, 18 Sep 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b="M8uyWbQh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747D1BBBCA
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670447; cv=none; b=vEdmx5EzTFHWDvKeE4A3640DVa4fD1d1WoXdeQ1aPeYuQyt48/f3DV/5Xe4ylrwN7icVN/Yab8lxOXE3BfYr3E1JJV/r4RBi2hKuikbU0r0/S6a19zy39Mo1LqIszAjNZxcJhODthvN9IWNFUJGhpsOAYTyzjOxB0rO7fsZHpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670447; c=relaxed/simple;
	bh=V5oE67Pa0qSHYitoE97MI//EA3etwfig1kWpYm8JkDw=;
	h=Date:MIME-Version:Subject:From:To:References:In-Reply-To:
	 Content-Type:Message-ID; b=DdvuYKu3kYya3wH0ycO0ncQapufKBKyJUfBXLHHes4AUlkJ8GdyJ832srvlIdK5V4+XilW5122JwtitUzgpQWsETH1mhoA4IhWY0RggzAxYmHRIMkDAW5ZwPEEmDpRcZAGwH5kxgDBOQoURwIi46Fq93zkoZAcKcNZ7kPAeIwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b=M8uyWbQh; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1726670436; x=1727275236; i=dknueppel@online.de;
	bh=V5oE67Pa0qSHYitoE97MI//EA3etwfig1kWpYm8JkDw=;
	h=X-UI-Sender-Class:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M8uyWbQh8QqdXVvRJ1DDCTKKX3YpYpK4ie3pE3nCzlM/gyUIUn9LyWjOyvYHjD9d
	 DUACuURk4mrmCOMHq9vojOeaJQ9m0PfCmuI1Jgzz2YMk5T9/pPSIHjIGFpKCvqh+h
	 ay5zhDgDNC8et4jvMF4/5ziFwePIWwhIBOg+sk0pLeECxjo8J+GO9OqrPXKfaOEb0
	 nulEmTkG8CEoaRExSMoe0RTRHN9ANsoxnDaLrBASAaCA64enY1ig1eoDL/oOg9lCP
	 moGF0mk6do7qxWKA7kDqgHBRemuvQQDpJReUIggOgmL4liHNM5qj7CPW9KtaHH1az
	 jev1F3/tW+nO1wlmNQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from xXx ([87.122.98.153]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MzQTm-1s4LY4357Y-00vqdk for
 <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 16:40:36 +0200
Authentication-Results: kalliope-7.home.xx;
	auth=pass smtp.auth=dknueppel@home.xx smtp.mailfrom=dknueppel@home.xx
Date: Wed, 18 Sep 2024 16:40:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ath12k - HTT timeout error with NCM86
From: Dieter Knueppel <dknueppel@online.de>
To: linux-wireless@vger.kernel.org
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
Content-Language: en-US
In-Reply-To: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.09 / 6.00];
	BAYES_HAM(-2.99)[99.94%];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: kalliope-7
X-Rspamd-Queue-Id: C57073F90F
Message-ID: <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
X-Provags-ID: V03:K1:RcQvMzncw13Lt7OsVGlCs5BbPZ6/dckqTyK8xjNg6hiO1hI+cLb
 x02XjCNnb1qB+hYJqSORYB3b1oFAgmBdSTtWwqu2ASneZWdmTZO2Pl/Q00P/g2K2Kbn2huz
 yYR7OkOZEtX0Tg6orJmYdjLB60ma1Za/iTPstwqfTj+x0qeFV4O2bhetAnEw3pNqA5MABd+
 fTMrm+BYLMFwnnWVSWpmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FGcMP9KgtYk=;Yk8Mu1Rwj+DgjSZqECcSPAVVtfB
 tDXlFhJmNFOeSO+rZ38rN56vtGnauCveJChBDCzQL3o1RnuL20QJX4TjutzkJK/5KFI2DWv68
 /oFepUW4YCIS6MxT+0BptOx0oMzt0I0j/q1Bpqolpprm8Yf1ChaEvXm3R5klQxQEF9sbovhdo
 Pil1u/q3BniNjeQwo014cBBC+TLiHjy8i1giXE7niz2g+N0Xg3W0YxohT1FZdC+D8j46wGRL+
 Go2aJksv46QQMrkeHuo75rKalAOBRZaNirGeGGYH/aUGml31Sayrfr5j1YND+F8Q7hjvjBp1l
 W0qMVDxLGHT8s0v0CwsIIq4m9eagN9WsRtOKaCyEyOiAiChFn7JYlDgHJh2A0/mFk/ypaqCSJ
 6pqBeyrNK7mI1kNXNhnYxu7btJGZ0Ec5N1nUD04e7zH3G4+dCmjd1rbbC6qTA8EBC1NAX70+9
 LiPyZ1cRjbrOIoDngM5WL1n3sl30GGWyNtQb0ElJxj9/6lVb5deX/7Iqbv2H+bUZwgRlDGXUa
 TnEBW6qNyokdYsetSRnqTBq4P9RizeXFAUimuam+OK1xHhks9B5kHjDFCM/bbBQ908+zzx18m
 cRY9jdpY4xsVyP8xsisdDCCa9grZzACYLPWflyXxlGSNE4/P9oA7KArWUGhAL4B90akiWc/4u
 AeHqwB+7njSEqdIk6n4M9cIvaOF/1PG+WYa8EajOBpsf7/e3iTJ4dDoEG2ub7ZhQE8qzOzBKl
 UEh+fLywzxSNjg04Ke7BqYrhP0oYEokLw==

Dear developer team,

I have to admit, the earlier post "HTT timeout error with NCM86" is my
fault, sorry for causing confusion.

Due to earlier tests with legacy cards, the PCIe slot was still forced
to Gen2 :-(

Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyte
WC-WIFI7" i

consistently get: "Unknown hardware version found for WCN7850: 0xf"

Which nails down to the question whether any of these adapter is already
supported?

The M.2 NCM865 card as such seems to be supported.

I'm wondering about the difference, as there seems to be no additional
logic compiled

on one of the two PCIe boards, just bit of glue logic.


Thanks a lot for any hint,

Dieter




