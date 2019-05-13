Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB531B619
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfEMMhx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 08:37:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfEMMhx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 08:37:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE95560A0A; Mon, 13 May 2019 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557751072;
        bh=tPouinMg0xgfsTmzm8uB5YRUndo7XORITezmpzKY0e4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XiTCIf/K8DtOspxYZgRABk4aiFxx3SLiezeucaPd/Id1bGiti2bqtR78/3ZFXz5dO
         5cevAfsU015Pu8RnuSHTDMFACfTWjET0tzmMYZ+jQJivL6dUiA+1Ec477pyw1p6Vul
         JkpPNjIdoXCg1Oci7NQC0iP2AdpQv0lpJGoYPAtg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E0486030E;
        Mon, 13 May 2019 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557751072;
        bh=tPouinMg0xgfsTmzm8uB5YRUndo7XORITezmpzKY0e4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XiTCIf/K8DtOspxYZgRABk4aiFxx3SLiezeucaPd/Id1bGiti2bqtR78/3ZFXz5dO
         5cevAfsU015Pu8RnuSHTDMFACfTWjET0tzmMYZ+jQJivL6dUiA+1Ec477pyw1p6Vul
         JkpPNjIdoXCg1Oci7NQC0iP2AdpQv0lpJGoYPAtg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E0486030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
References: <cover.1557591530.git.lorenzo@kernel.org>
        <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
        <87r293ugia.fsf@purkki.adurom.net>
        <20190513084127.GA3127@localhost.localdomain>
Date:   Mon, 13 May 2019 15:37:48 +0300
In-Reply-To: <20190513084127.GA3127@localhost.localdomain> (Lorenzo Bianconi's
        message of "Mon, 13 May 2019 10:41:28 +0200")
Message-ID: <87sgtiil7n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Introduce a knob in mt7603 debugfs in order to enable/disable
>> > edcca processing
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> It's good to explain what edcca does and how the file is used supposed
>> to be used. In other words, have a small introduction for the user.
>
> Hi Kalle,
>
> edcca is used for adjusting energy detect based on CCA thresholds.
> The code was already there so I just reported the acronym.

A lot of people read commit logs but not everyone (myself included) are
familiar with mt76 internals so please try to explain the acronyms and
the background of the patch. Also you should explain in the commit log
_why_ you are adding the debugfs file, how it helps the user and how to
use it.

-- 
Kalle Valo
