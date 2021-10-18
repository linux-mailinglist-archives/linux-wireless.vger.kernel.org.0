Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44002431707
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJRLSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:18:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhJRLSy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:18:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634555803; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sKDESNe0Pi4Awtz4+OnDEEzLi4kqm1zMLVpBE5jNYAk=; b=f7ZyiusHOOEpkwT6VlCGGF0vpUKRiJEYmz/fxUH8wAkYi3KV5NgfeRtY/ZTh/xllSy8+BOrp
 xMOEBOxy87MuTtMC2Ifco7JZ+Wm+woch7LDdv4FABpfl38e8YN2mhIQXDip3fiyrCtLPrfeY
 H3Upx/JV1NwpsobG1K9vGIEmuv0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 616d57898ea00a941f8dc4b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:16:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87E82C4338F; Mon, 18 Oct 2021 11:16:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B244C4338F;
        Mon, 18 Oct 2021 11:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6B244C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 5/7] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-5-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 14:16:18 +0300
In-Reply-To: <20210811105541.43426-5-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:39 +0300")
Message-ID: <87h7devb0d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> iwlmei allows to integrate with the CSME firmware. There are
> flows that are prioprietary for this purpose:
>
> * Get the information of the AP the CSME firmware is connected
>   to. This is useful when we need to speed up the connection
>   process in case the CSME firmware has a TCP connection
>   that must be kept alive across the ownership transition.
> * Forbid roaming, which will happen when the CSME firmware
>   wants to tell the user space not disrupt the connection.
> * Request ownership, upon driver boot when the CSME firmware
>   owns the device. This is a notification sent by the kernel.
>
> All those commands are expected to be used by any software
> managing the connection (mainly NetworkManager). Those commands
> are expected to be used only in case the CSME firmware owns
> the device and doesn't want to release the device unless the
> host made sure that it can keep the connectivity.

[...]

> --- /dev/null
> +++ b/include/uapi/linux/nl80211-vnd-intel.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
> + * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
> + * Copyright (C) 2016-2017 Intel Deutschland GmbH
> + */
> +#ifndef __VENDOR_CMD_INTEL_H__
> +#define __VENDOR_CMD_INTEL_H__
> +
> +#define INTEL_OUI	0x001735
> +
> +/**
> + * enum iwl_mvm_vendor_cmd - supported vendor commands
> + * @IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO: reports CSME connection info.
> + * @IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP: asks for ownership on the device.
> + * @IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT: notifies if roaming is allowed.
> + *	It contains a &IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN and a
> + *	&IWL_MVM_VENDOR_ATTR_VIF_ADDR attributes.
> + */
> +
> +enum iwl_mvm_vendor_cmd {
> +	IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO			= 0x2d,
> +	IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP			= 0x30,
> +	IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT		= 0x32,
> +};

If I were trying to implement a user space application based on the
documentation in nl80211-vnd-intel.h I would not get far. For example,
how is IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP supposed to be used? The
documentation just repeats what the command already implies.

You had some good info in the commit log, I recommend at least copying
the most important part to the .h file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
