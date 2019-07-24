Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415E072E08
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfGXLqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:46:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGXLqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:46:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65BAB60ACE; Wed, 24 Jul 2019 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563968804;
        bh=8GMy6D9kKSxX1S2u4a7+1Kw8UopIWsJg3jqvMN3WoMo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jUrnCMmi5Bzem/XphkYN48AykMbjBE+gxZGhIeZd5YJElWWB1+xcV1AZBKx9RDHSP
         FwI4tOaRBu2aYFqbSd7MMEDSmXJB/J4KuH2mRyoX33z2XumpKhvN4GR93YDq/8kKzf
         0RSrgP52YyS4qNOPQGlJc69V7GHyKbYtU75gHHl4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C7A5605A0;
        Wed, 24 Jul 2019 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563968802;
        bh=8GMy6D9kKSxX1S2u4a7+1Kw8UopIWsJg3jqvMN3WoMo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ka2nhMBTr36hbaZxPYaYrU3WubcNoc3qj3znL2XGpSaBLSlP7Owbk7Z4Kt9cON1pE
         tmkieEpQG8pVFr/nLYjIbCZGGtjjmpVS0mRp4ARf/n6/zN62oRUQi4tRA5XoPjctDV
         /mFUHQmlmH3aZQZLIaMDYMljrtgmWh6jgVcF/Yl8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C7A5605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] libertas: Fix a double free in if_spi_c2h_data()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <ee4472e4728becc9713962ba264742cb1f337098.camel@redhat.com>
References: <ee4472e4728becc9713962ba264742cb1f337098.camel@redhat.com>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Philip Rakity <prakity@yahoo.com>,
        libertas-dev@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Allison Randal <allison@lohutok.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724114644.65BAB60ACE@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:46:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Williams <dcbw@redhat.com> wrote:

> The lbs_process_rxed_packet() frees the skb.  It didn't originally, but
> we fixed it in commit f54930f36311 ("libertas: don't leak skb on receive
> error").
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dan Williams <dcbw@redhat.com>

Failed to compile:

drivers/net/wireless/marvell/libertas/if_spi.c: In function 'if_spi_c2h_data':
drivers/net/wireless/marvell/libertas/if_spi.c:771:11: error: expected ';' before '}' token
   goto out
           ^
           ;
  }
  ~         
make[5]: *** [drivers/net/wireless/marvell/libertas/if_spi.o] Error 1
make[4]: *** [drivers/net/wireless/marvell/libertas] Error 2
make[3]: *** [drivers/net/wireless/marvell] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11033059/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

