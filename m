Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BC115ED
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEBJBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 05:01:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBJBX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 05:01:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 270B0608CE; Thu,  2 May 2019 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556787682;
        bh=WR3eXYd2x4/T7A9yJCIXP7VTD129ETaqgaiMipVTfkg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wj4gGL+DGn3Dz8+EjTU4FY6OIjPRxt7mOLVaasmMjOc7lUjxF+C4xXGXesyp7YsOm
         uNCvarOloXjY5cyoTX6Zs8DRfV+KPLzp6rcwjW3zpm2lM0EIRBitYvgzYMGb4wQ4Ah
         PaCWCIfn1h9B6cr+mS1kHdpYPVgc7LFo0G3aK1CM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E4CF607B9;
        Thu,  2 May 2019 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556787681;
        bh=WR3eXYd2x4/T7A9yJCIXP7VTD129ETaqgaiMipVTfkg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nGhErUVF818feHISJoZLctMpwHK8d4hGqBNP43DUXzqGfoQDHN2bN5iBbEswVmlAr
         JbcAkY0uy4SLaLqONkz3Wk5OoC1e78nLaiVQJ2Raq6nfXg1FZhejynK9W8ceYcvLKt
         3tg9jXTTJZ7AnTsip/yGFRiTZQrCLxUABs1Oea1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E4CF607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [RFC 08/17] mt7615: remove query from mt7615_mcu_msg_send signature
References: <cover.1556726268.git.lorenzo@kernel.org>
        <4726f34219aa6a01158e53ee2f40db248ef6c9e4.1556726268.git.lorenzo@kernel.org>
Date:   Thu, 02 May 2019 12:01:17 +0300
In-Reply-To: <4726f34219aa6a01158e53ee2f40db248ef6c9e4.1556726268.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 1 May 2019 18:07:30 +0200")
Message-ID: <87ftpxw7qa.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Please no empty commit logs. As this is a trivial patch you can just add
a sentence explaining why you do this.

-- 
Kalle Valo
