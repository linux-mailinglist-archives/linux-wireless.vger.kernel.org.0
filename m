Return-Path: <linux-wireless+bounces-7892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6748CAB40
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4120EB22CFC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAFD6EB62;
	Tue, 21 May 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlVEIXeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F96BB58
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284990; cv=none; b=TKjxpdFRe6cxqA19nYPWQMTxMofcBk6CLwW6LfSaypwqxEzwfJN0Ama19AKeIlkWEYOXsp5ibOWi0/19Bdhcc4osWsqEDcIUBe+Vl7NJ9TYH5Sl+jAkQJTFbKYz1MjVahJgNf68gS7F5GUtwambvTMW6fLlfszqJBkbFfSP9W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284990; c=relaxed/simple;
	bh=cyctKyZ6xv3Jcv1nSJ8Y7GXV2A4M4LjyR/6XGLxRfIA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IYR3rtmX5sdkhMWBfrjW6h+VU1e4xaoM4A2OuHkLlNxOJrHQ5TfsrOvyBaMQRXysAeXGnuz/64D9pcWEHZCi3QaPY9FyNtFOm01Nt/U+hlw25zV99lx+sdeCjVG7ShoSsbtQdW7YQU4xPlRXVJf4d8Tc4rys6Tf7i1va55LV+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlVEIXeF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57824fa0a8fso449033a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284987; x=1716889787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttQWlXfImZ6VMs6eXr/g1fKwqzPLEk4Ki4n5JP6tD3U=;
        b=UlVEIXeF9L9VmYBcySFxxm6Zn0A0DmUQkHGoAvQbuTBGaLKYQEQHUY594AhxtSM4Z4
         t5ho59eXcPy5DlgX6V1bVXdaUw1fCpVI/2o5VdSa3mS/m5f09QiJXgrpzX5uZEePjYeE
         O4suCcEynHh5bZ67boxxGQJ8N3uJkm7Y3HRtyPStgmGGpzKR0xprTP2udDQivbMvkprh
         knZCtK5W0XBRIVYws0vYcKs09/U6SkfERQAvInThiv2xBq7LcyUYQAJSYgKQJkaFTPbJ
         Gw0lMuqCOXyMcV8YtcZe7fYXPVFrgGnmL3l7v3rCLeB648pJmEDtnn4zD2Q2xEXCCuju
         00Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284987; x=1716889787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttQWlXfImZ6VMs6eXr/g1fKwqzPLEk4Ki4n5JP6tD3U=;
        b=Cl9bg+G8j68AOyp1W4SZq94UuDfGYUtbgSHIduQo4hNBVPMXcSwuwb9QYC4bfg4I47
         ZTnpAQN2Q4Gpsle67W1H4huPFY7zaSZZydg1OHyIfN8yhk2JXs7uDr32w0TcaaNF1vo3
         JDXnkB3y7NKPS7W5ykcUbd4k/PUectx/57mDCiI2OBkRiXcav/vnqVD93QsdjJ2s2/SV
         GxfuatsCgFehRl6wa0XnE1KbPnslNDRaqdVu5OF3iMhvO8VpzT5zCIfIotGKyuIp8NFY
         B8za47j7tY6SPW/iXwKUETu4Oe5fO5mXF1f5E7FSY7i/Zt/q0E1GgAvsUCFu0ZYl/got
         1/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXgK3/O1r8/dz4BWGGrkmcwhX51wUtFLaUMwO9CRhsN1JdhNpIef0xoGOX+sV1Y0kHriUFufnJ+Ept41xYEf5KV0R6vzzyFeusxk/pv9iI=
X-Gm-Message-State: AOJu0YyYwYJKGKD2Gyb9q2+/Qry9ca6CUoVJP6hg5sv9q9BwS2qloO2r
	GhIgnqKZdSClW+qB/FN+Yyoeh9+PCnmGdQc4NFoW1gNuIFZ0iNObaQm9vXH4Bj8=
X-Google-Smtp-Source: AGHT+IGYZltjqowB77AWpArr9RoGUzhswwEoZofmoJx6mtx/FkQZFqOw8katShiW6munDZHWImZ4gg==
X-Received: by 2002:a17:906:4a49:b0:a59:ba2b:590f with SMTP id a640c23a62f3a-a5a2d67806emr1778800866b.67.1716284987191;
        Tue, 21 May 2024 02:49:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:adf9:e5d:4c15:f725? ([2a01:e0a:982:cbb0:adf9:e5d:4c15:f725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5d08d36feasm577491566b.15.2024.05.21.02.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:49:46 -0700 (PDT)
Message-ID: <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
Date: Tue, 21 May 2024 11:49:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 06/12] remoteproc: qcom_q6v5_pas: switch to mbn files by
 default
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> We have been pushing userspace to use mbn files by default for ages.
> As a preparation for making the firmware-name optional, make the driver
> use .mbn instead of .mdt files by default.

I think we should have a mechanism to fallback to .mdt since downstream
uses split mdt on the devices filesystem.

Perhaps only specify .firmware_name = "adsp" and add a list of allowed extension
it will try in a loop ?

Neil

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 76 +++++++++++++++++++-------------------
>   1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 54d8005d40a3..4694ec4f038d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -812,7 +812,7 @@ static void adsp_remove(struct platform_device *pdev)
>   
>   static const struct adsp_data adsp_resource_init = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.ssr_name = "lpass",
> @@ -822,7 +822,7 @@ static const struct adsp_data adsp_resource_init = {
>   
>   static const struct adsp_data sdm845_adsp_resource_init = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.load_state = "adsp",
> @@ -833,7 +833,7 @@ static const struct adsp_data sdm845_adsp_resource_init = {
>   
>   static const struct adsp_data sm6350_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -849,7 +849,7 @@ static const struct adsp_data sm6350_adsp_resource = {
>   
>   static const struct adsp_data sm6375_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> +	.firmware_name = "modem.mbn",
>   	.pas_id = 4,
>   	.minidump_id = 3,
>   	.auto_boot = false,
> @@ -864,7 +864,7 @@ static const struct adsp_data sm6375_mpss_resource = {
>   
>   static const struct adsp_data sm8150_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -879,7 +879,7 @@ static const struct adsp_data sm8150_adsp_resource = {
>   
>   static const struct adsp_data sm8250_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -895,7 +895,7 @@ static const struct adsp_data sm8250_adsp_resource = {
>   
>   static const struct adsp_data sm8350_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -911,7 +911,7 @@ static const struct adsp_data sm8350_adsp_resource = {
>   
>   static const struct adsp_data msm8996_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> +	.firmware_name = "adsp.mbn",
>   	.pas_id = 1,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -925,7 +925,7 @@ static const struct adsp_data msm8996_adsp_resource = {
>   
>   static const struct adsp_data cdsp_resource_init = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.ssr_name = "cdsp",
> @@ -935,7 +935,7 @@ static const struct adsp_data cdsp_resource_init = {
>   
>   static const struct adsp_data sdm845_cdsp_resource_init = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.load_state = "cdsp",
> @@ -946,7 +946,7 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
>   
>   static const struct adsp_data sm6350_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -962,7 +962,7 @@ static const struct adsp_data sm6350_cdsp_resource = {
>   
>   static const struct adsp_data sm8150_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -977,7 +977,7 @@ static const struct adsp_data sm8150_cdsp_resource = {
>   
>   static const struct adsp_data sm8250_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -992,7 +992,7 @@ static const struct adsp_data sm8250_cdsp_resource = {
>   
>   static const struct adsp_data sc8280xp_nsp0_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1006,7 +1006,7 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
>   
>   static const struct adsp_data sc8280xp_nsp1_resource = {
>   	.crash_reason_smem = 633,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 30,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1020,8 +1020,8 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
>   
>   static const struct adsp_data x1e80100_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> -	.dtb_firmware_name = "adsp_dtb.mdt",
> +	.firmware_name = "adsp.mbn",
> +	.dtb_firmware_name = "adsp_dtb.mbn",
>   	.pas_id = 1,
>   	.dtb_pas_id = 0x24,
>   	.lite_pas_id = 0x1f,
> @@ -1040,8 +1040,8 @@ static const struct adsp_data x1e80100_adsp_resource = {
>   
>   static const struct adsp_data x1e80100_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> -	.dtb_firmware_name = "cdsp_dtb.mdt",
> +	.firmware_name = "cdsp.mbn",
> +	.dtb_firmware_name = "cdsp_dtb.mbn",
>   	.pas_id = 18,
>   	.dtb_pas_id = 0x25,
>   	.minidump_id = 7,
> @@ -1060,7 +1060,7 @@ static const struct adsp_data x1e80100_cdsp_resource = {
>   
>   static const struct adsp_data sm8350_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> +	.firmware_name = "cdsp.mbn",
>   	.pas_id = 18,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1076,7 +1076,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
>   
>   static const struct adsp_data mpss_resource_init = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> +	.firmware_name = "modem.mbn",
>   	.pas_id = 4,
>   	.minidump_id = 3,
>   	.auto_boot = false,
> @@ -1093,7 +1093,7 @@ static const struct adsp_data mpss_resource_init = {
>   
>   static const struct adsp_data sc8180x_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> +	.firmware_name = "modem.mbn",
>   	.pas_id = 4,
>   	.auto_boot = false,
>   	.proxy_pd_names = (char*[]){
> @@ -1108,7 +1108,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
>   
>   static const struct adsp_data msm8996_slpi_resource_init = {
>   	.crash_reason_smem = 424,
> -	.firmware_name = "slpi.mdt",
> +	.firmware_name = "slpi.mbn",
>   	.pas_id = 12,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1122,7 +1122,7 @@ static const struct adsp_data msm8996_slpi_resource_init = {
>   
>   static const struct adsp_data sdm845_slpi_resource_init = {
>   	.crash_reason_smem = 424,
> -	.firmware_name = "slpi.mdt",
> +	.firmware_name = "slpi.mbn",
>   	.pas_id = 12,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1138,7 +1138,7 @@ static const struct adsp_data sdm845_slpi_resource_init = {
>   
>   static const struct adsp_data wcss_resource_init = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "wcnss.mdt",
> +	.firmware_name = "wcnss.mbn",
>   	.pas_id = 6,
>   	.auto_boot = true,
>   	.ssr_name = "mpss",
> @@ -1148,7 +1148,7 @@ static const struct adsp_data wcss_resource_init = {
>   
>   static const struct adsp_data sdx55_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> +	.firmware_name = "modem.mbn",
>   	.pas_id = 4,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1163,7 +1163,7 @@ static const struct adsp_data sdx55_mpss_resource = {
>   
>   static const struct adsp_data sm8450_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> +	.firmware_name = "modem.mbn",
>   	.pas_id = 4,
>   	.minidump_id = 3,
>   	.auto_boot = false,
> @@ -1181,8 +1181,8 @@ static const struct adsp_data sm8450_mpss_resource = {
>   
>   static const struct adsp_data sm8550_adsp_resource = {
>   	.crash_reason_smem = 423,
> -	.firmware_name = "adsp.mdt",
> -	.dtb_firmware_name = "adsp_dtb.mdt",
> +	.firmware_name = "adsp.mbn",
> +	.dtb_firmware_name = "adsp_dtb.mbn",
>   	.pas_id = 1,
>   	.dtb_pas_id = 0x24,
>   	.minidump_id = 5,
> @@ -1200,8 +1200,8 @@ static const struct adsp_data sm8550_adsp_resource = {
>   
>   static const struct adsp_data sm8550_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> -	.dtb_firmware_name = "cdsp_dtb.mdt",
> +	.firmware_name = "cdsp.mbn",
> +	.dtb_firmware_name = "cdsp_dtb.mbn",
>   	.pas_id = 18,
>   	.dtb_pas_id = 0x25,
>   	.minidump_id = 7,
> @@ -1220,8 +1220,8 @@ static const struct adsp_data sm8550_cdsp_resource = {
>   
>   static const struct adsp_data sm8550_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> -	.dtb_firmware_name = "modem_dtb.mdt",
> +	.firmware_name = "modem.mbn",
> +	.dtb_firmware_name = "modem_dtb.mbn",
>   	.pas_id = 4,
>   	.dtb_pas_id = 0x26,
>   	.minidump_id = 3,
> @@ -1243,7 +1243,7 @@ static const struct adsp_data sm8550_mpss_resource = {
>   
>   static const struct adsp_data sc7280_wpss_resource = {
>   	.crash_reason_smem = 626,
> -	.firmware_name = "wpss.mdt",
> +	.firmware_name = "wpss.mbn",
>   	.pas_id = 6,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
> @@ -1259,8 +1259,8 @@ static const struct adsp_data sc7280_wpss_resource = {
>   
>   static const struct adsp_data sm8650_cdsp_resource = {
>   	.crash_reason_smem = 601,
> -	.firmware_name = "cdsp.mdt",
> -	.dtb_firmware_name = "cdsp_dtb.mdt",
> +	.firmware_name = "cdsp.mbn",
> +	.dtb_firmware_name = "cdsp_dtb.mbn",
>   	.pas_id = 18,
>   	.dtb_pas_id = 0x25,
>   	.minidump_id = 7,
> @@ -1283,8 +1283,8 @@ static const struct adsp_data sm8650_cdsp_resource = {
>   
>   static const struct adsp_data sm8650_mpss_resource = {
>   	.crash_reason_smem = 421,
> -	.firmware_name = "modem.mdt",
> -	.dtb_firmware_name = "modem_dtb.mdt",
> +	.firmware_name = "modem.mbn",
> +	.dtb_firmware_name = "modem_dtb.mbn",
>   	.pas_id = 4,
>   	.dtb_pas_id = 0x26,
>   	.minidump_id = 3,
> 


