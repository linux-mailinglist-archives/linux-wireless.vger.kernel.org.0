Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3F96AB1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfHTUcw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:32:52 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43574 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfHTUcw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:32:52 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AoB-00084G-HX; Tue, 20 Aug 2019 22:32:47 +0200
Message-ID: <0c526ce00e6e1c7731c990515e7438230efb55af.camel@sipsolutions.net>
Subject: Re: [PATCH 08/49] ath11k: add core.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:32:45 +0200
In-Reply-To: <1566316095-27507-9-git-send-email-kvalo@codeaurora.org> (sfid-20190820_175156_803421_4FF79584)
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-9-git-send-email-kvalo@codeaurora.org>
         (sfid-20190820_175156_803421_4FF79584)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
> +
> +MODULE_PARM_DESC(debug_mask, "Debugging mask");
> +
> +static const struct ath11k_hw_params ath11k_hw_params = {
> +			.name = "ipq8074",

indentation here seems a bit too much

> +MODULE_LICENSE("Dual BSD/GPL");

All your files state "ISC", shouldn't that be reflected here?

johannes

