Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4846CB8AF2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394794AbfITGRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 02:17:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393094AbfITGRN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 02:17:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E26A861197; Fri, 20 Sep 2019 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568960232;
        bh=WtC26mDlgtl3+WBvaJV+k9yuQ4fyIfV0QCdliHeBs0Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VN6B5d9O7Ej7a1qAWtgEh/lpRbQbdf+zYhxukKx2ryuXwQUQATYYmgj7KP6rYZHMB
         GDagPA7VLSIM8gLhE4/VN2WeYp54+FJrWxVOfAdri/5mrC8SCI3b3zv2b3oS/rO5GY
         dsLg6WEgwSzQBR3NE9fJzJYA1ShN6BLWi+9gZ7ac=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56E5B60736;
        Fri, 20 Sep 2019 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568960232;
        bh=WtC26mDlgtl3+WBvaJV+k9yuQ4fyIfV0QCdliHeBs0Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VN6B5d9O7Ej7a1qAWtgEh/lpRbQbdf+zYhxukKx2ryuXwQUQATYYmgj7KP6rYZHMB
         GDagPA7VLSIM8gLhE4/VN2WeYp54+FJrWxVOfAdri/5mrC8SCI3b3zv2b3oS/rO5GY
         dsLg6WEgwSzQBR3NE9fJzJYA1ShN6BLWi+9gZ7ac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56E5B60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: Re: [PATCH] rtlwifi: rtl_pci: Fix errors when CONFIG_RTLWIFI_DEBUG is not set
References: <20190920022533.23085-1-Larry.Finger@lwfinger.net>
Date:   Fri, 20 Sep 2019 09:17:08 +0300
In-Reply-To: <20190920022533.23085-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Thu, 19 Sep 2019 21:25:33 -0500")
Message-ID: <87y2yjcx0b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> When rtlwifi debugging is disabled, missing globals occur due to the
> attempt execution of code that is never generated.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Is this is a new regression or an old problem?

-- 
Kalle Valo
