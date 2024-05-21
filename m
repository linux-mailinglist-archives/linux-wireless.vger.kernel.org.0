Return-Path: <linux-wireless+bounces-7894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD08CAB48
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D685A1F21ABD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF86BB45;
	Tue, 21 May 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uh0DczXW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9561664
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285174; cv=none; b=QYVXEhSqT+RfkEg0yQwDvQouVijbxnhSq1G5BXSfKKKZSc1eZZWY8FcwDXAtEQN8VSbKcl8+5VFDWdT20e/YTii8WZrwX0zdKAfNmJJvssqBU50634b25+LLV30fvCs8hY/zbHpbeY10qOE+vfA1ixSxR9zpZpI616l8nD6B0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285174; c=relaxed/simple;
	bh=WDNsksPAPWELnAYXudqubJzqQX0axMbrLNKACc8Z69w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MMMvXuiGW8+A64uCABqppB0a9eKelpqew128wAS2xkWeu5teEJCTW/tg/DAKx37X8oGU+eonEeY3NajIA3QkUh/8/xYWeeHXOah0A+FzvtnZYmpQTetrZkWDkFOt6Gk1gPeyCfRBYbZYFb6rRDSKap89LJ/2djutIC9MtfMk7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uh0DczXW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5238b5c080cso6452562e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716285170; x=1716889970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxNZmYdUy/J5wF9KOBHofLTNDbZCyaCYSUWokOsVSs8=;
        b=uh0DczXWJzgWSVhTjFnS2Xg7PU5YtLEVPnqfjfQ9yaKhYWdW7u6iqu0tf7QpV+Gqil
         S8gg5NiKUGGqzC9cx6XB8kSxPSX0TZK8O/+duRqsSEwWhLzIgw4TFMkANlSCaw5/TCY9
         N6FSD48LsLL2/OOf24iMWwpIlXvySBgStxUT5b78g2IdHxlQrR5NnAL6ExDe2OUAqSct
         fejAgeeIWNLtoQLttNobaJEcNiZkw3zwPol9Qu9j8IuHc0Ts/o4MqBUKSh9DImruDDBF
         pbLutVXP2GggGxCFYcCYKP+CcuvV9OKUgBB25gUEZTucWihnbz3m5Yy7KvNrxcbYGpJk
         0AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285170; x=1716889970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AxNZmYdUy/J5wF9KOBHofLTNDbZCyaCYSUWokOsVSs8=;
        b=vUMx51MQYKa+PZnHh50I7Nw9M2oC3KiuU96NrGGKmS0j016TiAYgP9l/5Mw5r8T/LO
         0GitXEtZkoxm/FQGzjGW3ria9GY/MeYoAwKtHfZmP+TYBocZ9m1oiuxc2m9DvHWJPebp
         7+0gc48NoC7gssm93JwuRaxY+EovUi2pCuU2rn9v4U7Pb4jHOTCdUzP4GHlEtyOt0hwD
         tUJOFZXR358OHJdlbCWEovAdpM/2G7HDoijRS3gKdWNOyo+ujfKhvadfFhEQX5TyZp5/
         I9vgXEk7TfaYE+dKHZkv4dMVSNKDcHzPBWHOlF4bMHeECltmcJi0C5vdIGdyt/wtDTUM
         a8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUN8X7QOT3RQKf8RVnJT7I4tf9ZR1tGWhUC8e6e90uSOwYrfRdYNGokngTVJ9XdnuQALJysqJf7c36EgnOUzeW2MA+akaG0LhCtk7TDFvI=
X-Gm-Message-State: AOJu0Yz4UDI1Hrp3wD+sODpLnl8jzSLjLcUNwSgq0d4FPUk4X0Cgxb16
	dckPBddjhYs9XHB3gvHN2iRZReclJzpQyVLPZ9IsgXKSTpr5iUYDSf6t2YmzS64=
X-Google-Smtp-Source: AGHT+IFdXiXyrzoApQgOdDWpb6iIVuhPyfhIL43KtoWriiwoy5lQ1Rf66cgFBdKJV6REetd4ddGLnA==
X-Received: by 2002:a05:6512:10cb:b0:524:43b2:d326 with SMTP id 2adb3069b0e04-52443b2d379mr4106211e87.37.1716285170365;
        Tue, 21 May 2024 02:52:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:adf9:e5d:4c15:f725? ([2a01:e0a:982:cbb0:adf9:e5d:4c15:f725])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ffe6d3f6sm7326896a12.0.2024.05.21.02.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:52:50 -0700 (PDT)
Message-ID: <a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org>
Date: Tue, 21 May 2024 11:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
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
 <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
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
In-Reply-To: <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> Qualcomm platforms have different sets of the firmware files, which
> differ from platform to platform (and from board to board, due to the
> embedded signatures). Rather than listing all the firmware files,
> including full paths, in the DT, provide a way to determine firmware
> path based on the root DT node compatible.

Ok this looks quite over-engineered but necessary to handle the legacy,
but I really think we should add a way to look for a board-specific path
first and fallback to those SoC specific paths.

Neil

> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/soc/qcom/Kconfig           |  5 +++
>   drivers/soc/qcom/Makefile          |  1 +
>   drivers/soc/qcom/qcom_fw_helper.c  | 86 ++++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/fw_helper.h | 10 +++++
>   4 files changed, 102 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 5af33b0e3470..b663774d65f8 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -62,6 +62,11 @@ config QCOM_MDT_LOADER
>   	tristate
>   	select QCOM_SCM
>   
> +config QCOM_FW_HELPER
> +	tristate "NONE FW HELPER"
> +	help
> +	  Helpers to return platform-specific location for the firmware files.
> +
>   config QCOM_OCMEM
>   	tristate "Qualcomm On Chip Memory (OCMEM) driver"
>   	depends on ARCH_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ca0bece0dfff..e612bee5b955 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
> +obj-$(CONFIG_QCOM_FW_HELPER)	+= qcom_fw_helper.o
>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>   obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
>   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
> diff --git a/drivers/soc/qcom/qcom_fw_helper.c b/drivers/soc/qcom/qcom_fw_helper.c
> new file mode 100644
> index 000000000000..13123c2514b8
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_fw_helper.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm Firmware loading data
> + *
> + * Copyright (C) 2024 Linaro Ltd
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/soc/qcom/fw_helper.h>
> +
> +static DEFINE_MUTEX(qcom_fw_mutex);
> +static const char *fw_path;
> +
> +static const struct of_device_id qcom_fw_paths[] = {
> +	/* device-specific entries */
> +	{ .compatible = "thundercomm,db845c", .data = "qcom/sdm845/Thundercomm/db845c", },
> +	{ .compatible = "qcom,qrb5165-rb5", .data = "qcom/sm8250/Thundercomm/RB5", },
> +	/* SoC default entries */
> +	{ .compatible = "qcom,apq8016", .data = "qcom/apq8016", },
> +	{ .compatible = "qcom,apq8096", .data = "qcom/apq8096", },
> +	{ .compatible = "qcom,sdm845", .data = "qcom/sdm845", },
> +	{ .compatible = "qcom,sm8250", .data = "qcom/sm8250", },
> +	{ .compatible = "qcom,sm8350", .data = "qcom/sm8350", },
> +	{ .compatible = "qcom,sm8450", .data = "qcom/sm8450", },
> +	{ .compatible = "qcom,sm8550", .data = "qcom/sm8550", },
> +	{ .compatible = "qcom,sm8650", .data = "qcom/sm8650", },
> +	{},
> +};
> +
> +static int qcom_fw_ensure_init(void)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *root;
> +
> +	if (fw_path)
> +		return 0;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -ENODEV;
> +
> +	match = of_match_node(qcom_fw_paths, root);
> +	of_node_put(root);
> +	if (!match || !match->data) {
> +		pr_notice("Platform not supported by qcom_fw_helper\n");
> +		return -ENODEV;
> +	}
> +
> +	fw_path = match->data;
> +
> +	return 0;
> +}
> +
> +const char *qcom_get_board_fw(const char *firmware)
> +{
> +	if (strchr(firmware, '/'))
> +		return kstrdup(firmware, GFP_KERNEL);
> +
> +	scoped_guard(mutex, &qcom_fw_mutex) {
> +		if (!qcom_fw_ensure_init())
> +			return kasprintf(GFP_KERNEL, "%s/%s", fw_path, firmware);
> +	}
> +
> +	return kstrdup(firmware, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_get_board_fw);
> +
> +const char *devm_qcom_get_board_fw(struct device *dev, const char *firmware)
> +{
> +	if (strchr(firmware, '/'))
> +		return devm_kstrdup(dev, firmware, GFP_KERNEL);
> +
> +	scoped_guard(mutex, &qcom_fw_mutex) {
> +		if (!qcom_fw_ensure_init())
> +			return devm_kasprintf(dev, GFP_KERNEL, "%s/%s", fw_path, firmware);
> +	}
> +
> +	return devm_kstrdup(dev, firmware, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(devm_qcom_get_board_fw);
> +
> +MODULE_DESCRIPTION("Firmware helpers for Qualcomm devices");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/soc/qcom/fw_helper.h b/include/linux/soc/qcom/fw_helper.h
> new file mode 100644
> index 000000000000..755645386bba
> --- /dev/null
> +++ b/include/linux/soc/qcom/fw_helper.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __QCOM_FW_HELPER_H__
> +#define __QCOM_FW_HELPER_H__
> +
> +struct device;
> +
> +const char *qcom_get_board_fw(const char *firmware);
> +const char *devm_qcom_get_board_fw(struct device *dev, const char *firmware);
> +
> +#endif
> 


