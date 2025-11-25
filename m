Return-Path: <linux-wireless+bounces-29320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54613C839C3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0190234792B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312532D323D;
	Tue, 25 Nov 2025 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="JRPRAfPo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453792BE64F
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054203; cv=none; b=pYIhd2sS4Nxh0vOvN37IxqWXHg2CyitdPfIUJXCKNC7O0gpyh5b9D6G+itqMdkLeGgopScH129nkqtC9C5sFGKxF9Ta6G3CX9/3Q7yzUzqlgYZoAeKOpsV36iJlTZftUYcADsycNdSHBsfKZM5LQpYNiYoKiwy5ijoRtVRAm74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054203; c=relaxed/simple;
	bh=oUq0yIY8y9uhoiTd7mBKtu3+DyecKsSfAdTK1y+jcUw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZLA3zCs244uTTaltECBy45kJQKUskykH4uaw0Y5jhHmQ+D9E5AFJO4RMUxpQM2msq9jAYc5xxXwYpLClw4lnfQgQ7gv26yYgaQkTRel0/g8gAxwWlhhn+BZz0ftqn00GX/7R0sHs4/qKjlKsrHxzQxHfoKxEQ3WksmNIUUGmTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=JRPRAfPo; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Message-ID: <33a8c6be-6946-41e3-aad7-fcd572e32a66@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764054189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZtbG4XYsDqlCvYnjir3vKy2J6xrwor92yZ1D35ysmU=;
	b=JRPRAfPopHyckZmsphbNveFeTSf0JNPgGMy25aQbcuAqaxGi2159ssntskqldZoZmHfZZX
	I+9ae27F+jIxuY+/2YkGiTHtPLfzt1ViLcyn63hG9RU5h4yICwGDZseelZqAKRzUNAdxlf
	7GkRDfxT8mOTRCAeqWzrjwhky4fkHodOWoJLA+Pk0Aga6MtN3BVrYLpbQ6AlkCLQ5tCUr6
	UFWflGh3lHjYPs57QiaRHSXMvOLJJfxoPe+ihmQPDq7VPKfAYZYXxW9VYFYIOVVycVQKFu
	MIuaCHz4oC6Zeg9+gGlmXFL+l9fN0r4+6LnuXt3MpfQkQaSw411wTLTP3zyiwA==
Date: Mon, 24 Nov 2025 23:03:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: devnull+david.ixit.cz@kernel.org
Cc: amit.pundir@linaro.org, andersson@kernel.org, ath10k@lists.infradead.org,
 conor+dt@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
 jjohnson@kernel.org, johannes@sipsolutions.net, konradybcio@kernel.org,
 krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 phone-devel@vger.kernel.org, robh@kernel.org
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
Subject: Re: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Paul Sajna <sajattack@postmarketos.org>
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Also required for 
https://lore.kernel.org/all/20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org/T/#m90e8087d4388e588b71a0eff01b88f1721f73b73


