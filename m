Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDA927A8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHSOzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:55:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSOzP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:55:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7640E6044E; Mon, 19 Aug 2019 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566226515;
        bh=Lxz+QfMpQO3l3ymESJ/B1m7Ab2snNyjE7G+/7zCeNBA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NaDoN45p9RTVLEzujmrfDYQktehJm4gauPitI6da0OIcLUbGOf5cue7Kx57yN1QdB
         /Mu86zfhXAII/yMmitZbhI3aoK6DO9kPy+/V/PrH8euvb+/O1R7prM+H1U5yjylRnY
         lZkNEP0NpgO14Gd3iBxBX1uKnf0OcXv6yltEXhXM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C69F606CF;
        Mon, 19 Aug 2019 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566226515;
        bh=Lxz+QfMpQO3l3ymESJ/B1m7Ab2snNyjE7G+/7zCeNBA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NaDoN45p9RTVLEzujmrfDYQktehJm4gauPitI6da0OIcLUbGOf5cue7Kx57yN1QdB
         /Mu86zfhXAII/yMmitZbhI3aoK6DO9kPy+/V/PrH8euvb+/O1R7prM+H1U5yjylRnY
         lZkNEP0NpgO14Gd3iBxBX1uKnf0OcXv6yltEXhXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C69F606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 09/22] iwlwifi: add ldbg config cmd debug print
References: <20190819143507.6989-1-luca@coelho.fi>
        <20190819143507.6989-10-luca@coelho.fi>
Date:   Mon, 19 Aug 2019 17:55:12 +0300
In-Reply-To: <20190819143507.6989-10-luca@coelho.fi> (Luca Coelho's message of
        "Mon, 19 Aug 2019 17:34:54 +0300")
Message-ID: <87mug5kxwv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
>
> add support to print ldbg command in mvm and xvt mode
>
> type=feature
> ticket=none
>
> Change-Id: Ic5a963db7785f616e49af7f7e7ee0cd86408e07d
> Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/223367
> automatic-review: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> Tested-by: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>

This needs some cleanup :) And also Luca's s-o-b.

-- 
Kalle Valo
