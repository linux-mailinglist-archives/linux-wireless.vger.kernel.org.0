Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E61CD8BA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 13:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgEKLnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 07:43:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54919 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729475AbgEKLnw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 07:43:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589197432; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YSWR2R+n2pCIB4AdAen4OJlpBFnCKilpkLWzZh9ACEk=; b=vtYL8x9WKZakcWOc6Zb6TteI2Nv+LE35+DZAcsC6yWL+EXvA0ckNX1PKZUVvVtg0jSZSbH7a
 dhh81t/qBVmo78o7Zi8tZ/OBpjxznX0B40eBNLDFqrKKSxeb4KU006N3P8/rOqHpJHzmLQxK
 L9/eCSNsDwP20EoOtEVGqe5fj1E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb93a76.7f1f1bb16810-smtp-out-n04;
 Mon, 11 May 2020 11:43:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3F19C433BA; Mon, 11 May 2020 11:43:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 642EDC433F2;
        Mon, 11 May 2020 11:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 642EDC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/11] iwlwifi: acpi: support device specific method (DSM)
References: <20200508140802.558267-1-luca@coelho.fi>
        <iwlwifi.20200508170402.d1f52b76e1a2.Icb48c8d61bede5dda7ef267bff10e4798e9dc77b@changeid>
Date:   Mon, 11 May 2020 14:43:46 +0300
In-Reply-To: <iwlwifi.20200508170402.d1f52b76e1a2.Icb48c8d61bede5dda7ef267bff10e4798e9dc77b@changeid>
        (Luca Coelho's message of "Fri, 8 May 2020 17:07:55 +0300")
Message-ID: <878shy66j1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Gil Adam <gil.adam@intel.com>
>
> ACPI Device Specific Method (DSM) allows standardized feature
> configuration through the ACPI interface without the namespace
> pollution of the usual mechanism (ACPI method for each feature).
> Add generic function for evaluating DSM objects and function for
> evaluating a DSM with no arguments and a single int return value.
> also implement the required backport for UUID.
>
> Signed-off-by: Gil Adam <gil.adam@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> -void *iwl_acpi_get_object(struct device *dev, acpi_string method)
> +const static guid_t intel_wifi_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,

Isn't the standard style "static const"?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
