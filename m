Return-Path: <linux-wireless+bounces-2264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B1832E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DF52883CE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775A55E74;
	Fri, 19 Jan 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALSyXIJ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5955E70
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685393; cv=none; b=FKv1m648cFSBQrhclAvYvfXENltVM67PBFvBnDLerVh47xDLTq/SqO8DH09FzZ0nx+XWyMN9zDjnoXejlfBPURti2lCYe8v7gMt2MEabpzG7PCGY8cbo6AJ0vf+d92E5qvPiL83ihiB9SmhQ0BKasHXb2A6PiMlH0J2Byz8+nYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685393; c=relaxed/simple;
	bh=FIEcrVqXgas66Xebc9DoCRhg0T9HmvplLARPN4iseQo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=XWypNpF6Xk5scf8tnbBdB2oy8zFlxfqtAvxzsaYkZS1F0hDGvFpkmsTeRReh215N1bvlJJlitk7rVAjXolM8U5m7O8g6Gi/M3odNPt8lmZQyiCHc5tx0EZ5mDThq20K3w9fKqAytRtnqY6iWM7WF2HkUHVYJFnHSrWB47wCciBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALSyXIJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E74C43390;
	Fri, 19 Jan 2024 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685393;
	bh=FIEcrVqXgas66Xebc9DoCRhg0T9HmvplLARPN4iseQo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ALSyXIJ1k2ctx616N6s0DIclhoWqo2esJ8WxMzYwi6/ves7MpcCLPxKHgGpyBJA+K
	 ZvXXLPO7ghGRIcOnnnnRpNxs3HfhBqk32M7USME555d+LGngu2xc/jmkVRE+c13KtW
	 /CWmLEUf4g+2pzRcWxRVS3ExJS8pzPrVhxB34SsKlwygoE+bu7s39q2pQbsPwBG5SE
	 3TMENLlizdQ11fhzPfKV56zqW9mvCbvGxM3WV1eCFXZn2te6aGshgBR9ApjNSURlKW
	 l3eqKIPv0yBZ84bNiu35Azeg9U2t5aFCBDRcuQyPUrqpu7DLI/Lp4ud+lxn/dn8EES
	 Fsy+hxc1JETGA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/4] wifi: brcmfmac: export firmware interface
 functions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103095704.135651-2-arend.vanspriel@broadcom.com>
References: <20240103095704.135651-2-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568539074.3153793.14376973552595278912.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:29:52 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> With multi-vendor support the vendor-specific module may need to use
> the firmware interface functions so export them using the macro
> BRCMF_EXPORT_SYMBOL_GPL() which exports them to driver namespace.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

4 patches applied to wireless-next.git, thanks.

31343230abb1 wifi: brcmfmac: export firmware interface functions
14e1391b7102 wifi: brcmfmac: add per-vendor feature detection callback
ba4d4726335c wifi: brcmfmac: move feature overrides before feature_disable
9f7861c56b51 wifi: brcmfmac: cfg80211: Use WSEC to set SAE password

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103095704.135651-2-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


