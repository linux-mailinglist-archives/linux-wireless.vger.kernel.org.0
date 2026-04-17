Return-Path: <linux-wireless+bounces-34955-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHs0FYmH4mkU7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34955-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:18:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80D41E2D9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFC923016D0F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CF3264F2;
	Fri, 17 Apr 2026 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UiHMd7rw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE338E11E
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453496; cv=none; b=Ezh+zaGRIiN3u6ovS3SvNgg+7eErmPssIGPDMsBavFj/opIrp6TmL0ejowqBsb1K+4iW2n00C04c7hFyUvfJe81sfz7zoQk2sjBQhTGqzc3EoT2BDKgO8f1Y7zNGzJr+Ux3pFiM0Mh/q3xifF0L4vhM8a8Ap8k2ntD8EKnwieSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453496; c=relaxed/simple;
	bh=i5Hr+IrciRHtIGa467IeTT2/L9/Aw6kLDM0TNojI/Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOTzJu7Qr5hNd2g8sYd4Q6fpO/y9AbLhd1efKnKSjDtJhHgnQGH/HtIWhzJlNaVw1ZVxVpTRAMeJqwe2RWBqDLzIGYNGuQ041OUR/uyURVCbxWUotov9nffHcWJlnQv1G+MOGCBozGkM3dtWUZj4UsbO8ya0Qatqq/Rghpy2M7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UiHMd7rw; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-12c726c30efso1029967c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453492; x=1777058292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVVQCF9h+sAxtCNaCmqreT3GLvw2hIVqYn5OjvvEPxY=;
        b=fILeGlTneEoqCLvcgFyWLwmI5DkuiV5p3FZ5OwXVw1uhhL+QcYGd+u+B40cAal19w6
         0adTGktmbMSEK/gmVpvZTh5y62rSsMPWKpsp+gnEqEJcq5/oAyHqCmHikNTitGNo+aUc
         SJb0QsH4NCZVz9w9/Dw2YbTVhl2vF7hDxpQ3YPVMgInZw7rNgim2CLhrV/dcqObn46c4
         gmoINnf59q6RRmBz1dm2PZ1swnQ0E0BPkwJqsa8XXRIqzD6msImB3eGHYvZhgnmBaUjE
         wIfgNeBM4HHFuu2eKdZQzyhwb/hg4Rvfmlpkpu7zZ1bJ1pheC9C49JoAfj/c9gGz+OuD
         gYBw==
X-Gm-Message-State: AOJu0Yyo01k/4d/Fm0RcAu8MpnuZAp4omNsM/YBxC07qiniM4kbOJJxu
	J70wLoQM+EmXNR3d8hMP8jGYfPMzbON6wkHnJgz0/3PdFjANCIITyDOuDbc3o8YM69+94d4gUNF
	HD9kksxuPogQ3uA1Y1SzF7KNTlK+2tTkyNdnbKLSI7NmZGN53agW/JTdK15eN6oRo79Y6OQzwBk
	AXcP3wYzlLtqRJRNwLMhBrdy8S0Ac30A1uV3fOJhC4oVZdwg/aGf8LqXgq/yRt8tmjKy1hoRR44
	8brZ01lWbnJVW1LelgzVDXRw7K0
X-Gm-Gg: AeBDiestkBwBtCPqycZ2qs8FisAiQhj2nWvDhqa/FdHI8JEFTIudN6a60xNSB//Q+xX
	xaGavouFUvkiVrPbrIpUJXZgDvSXDLaqy327X03BoQDazdehhJZfjzM5KwhZm9c6H6pc3HvOLiW
	wxEoJKqeOZbFjgYiSEpwHkGDKTeu/Dr7EUalH0LKab6s7lRBGt4CSON8Td1lSiiuNcWwe8fTxRX
	ETLbYEZzvyAO2Fk29oIBdcjYWmqGxxZwiHCjkopB4hJDAxTMYJwZHMjxYzr4QJH15nO6GDBn8WT
	HC4LngrNQ1vPrDSPhAZTEX6pLE0YeIxuTH91qOed5nKbECLsTGJ5h4VSs2gZjeOn4gNR9wouVtB
	3alNmzrWNFn/AVuJFdNcpe+qXzguBSsuo1HFPmRBin+fKpIDPURsiGMbgzgpkN+Ck1csDpCUVv7
	v1FmaMytWMPlmXRoFWZQaoys+LwFOLEyhG90NvABhdu5+WVgohq9QNTA/jLkHmxdZDOURC30M=
X-Received: by 2002:a05:7022:618a:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-12c73f64357mr2084057c88.1.1776453491286;
        Fri, 17 Apr 2026 12:18:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-90.dlp.protect.broadcom.com. [144.49.247.90])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12c74a03fa3sm138953c88.5.2026.04.17.12.18.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:18:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so19505411cf.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776453490; x=1777058290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVVQCF9h+sAxtCNaCmqreT3GLvw2hIVqYn5OjvvEPxY=;
        b=UiHMd7rw8BV4xrQ0ngTYBoHCfXo9mny5A5K3T+wr+InbRryL3OPspcfbUv3744/Jdb
         gjRbzCRuA72+gUwa7qQqzCmdoPzDIa47m9+B2oYeP38DXD+AmXDCibdqht7nFn8a7yhK
         LSJfNFQ2NNpsmemmqlbvfiEBJvS48X266Np/E=
X-Received: by 2002:a05:622a:59c9:b0:50b:4f75:c925 with SMTP id d75a77b69052e-50e36c2101dmr55295541cf.24.1776453489847;
        Fri, 17 Apr 2026 12:18:09 -0700 (PDT)
X-Received: by 2002:a05:622a:59c9:b0:50b:4f75:c925 with SMTP id d75a77b69052e-50e36c2101dmr55294981cf.24.1776453489402;
        Fri, 17 Apr 2026 12:18:09 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3948c861sm18615161cf.25.2026.04.17.12.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:18:08 -0700 (PDT)
Message-ID: <8fe89470-720e-4b30-a6a1-ac6ff58002d9@broadcom.com>
Date: Fri, 17 Apr 2026 21:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmsmac: phy_lcn: Remove dead code in
 wlc_lcnphy_radio_2064_channel_tune_4313()
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <20260403193324.141753-1-chelsyratnawat2001@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260403193324.141753-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34955-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B80D41E2D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/04/2026 21:33, Chelsy Ratnawat wrote:
> The variable rfpll_doubler is initialized to 0 and then unconditionally
> set to 1 on the very next line, making the subsequent check for
> !rfpll_doubler always evaluate to false. This results in logically
> dead code that has never been executed.
> 
> Remove the unused variable, the unreachable conditional branch, and
> simplify the fpfd calculation to directly use the PLL doubler values.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>   .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c       | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

