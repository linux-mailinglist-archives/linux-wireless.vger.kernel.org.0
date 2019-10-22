Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2DDFF6C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfJVI3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 04:29:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbfJVI3W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 04:29:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07F416083E; Tue, 22 Oct 2019 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571732961;
        bh=dfnexyKFgZ7M3DXnhgBgdvvHTwJwwPlBvK3aF2Dyz6g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=B7XsgLsTLag4wg7U0U2rWfWMi2EDUDJ1d15A0B2h8Hj7NIb7ghVma4TaC5MOq8gdY
         y4QLoTOEhFmr19lVpJTVh6ivp2wrSlh9hG5F62PT8OiuTboAraZb/BWcPX9L1h6Z0a
         sXyASotZhZvsCfPdV1J4dnUoW0brJRF2BwyPfx9g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EACA060790;
        Tue, 22 Oct 2019 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571732960;
        bh=dfnexyKFgZ7M3DXnhgBgdvvHTwJwwPlBvK3aF2Dyz6g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D3WZcfzK0XQ3ETVfJaKNyQPKxY0N8pfoMCjWOPXhkxdV8ECvEOVb1R7oNk3CHoW3p
         m+s+Ch565ofgrKW5JSt2dY3hseKLbjkPIogltKE9u3ykU6wVCU10rvrfun/eO/ePcy
         nU9aqSD+6O5MdiP+IXaUIF+m5j0iL+nVXpC3Cqz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EACA060790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-10-18
References: <3aa31c1474703a74e539d97720ce6ef68b3e5893.camel@coelho.fi>
Date:   Tue, 22 Oct 2019 11:29:16 +0300
In-Reply-To: <3aa31c1474703a74e539d97720ce6ef68b3e5893.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 18 Oct 2019 12:08:45 +0300")
Message-ID: <87mudttc83.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's the first batch of patches intended for v5.4.  This includes the
> last patchset 2 patchsets I sent.  Usual development work.  More
> details about the contents in the tag description.
>
> I pushed this to my pending branch and got results from kbuildbot for a
> previous version but not for the last one yet.  Though there shouldn't
> be any issues, since the changes were trivial.  I'll let you know when
> I get the results.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 89dca86d29b46f2a5f38ea6476cfd441bd205d25:
>
>   rtw88: mark rtw_fw_hdr __packed (2019-10-16 10:35:25 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-10-18
>
> for you to fetch changes up to e3277617c634b0efadb0429c59c8716531648415:
>
>   iwlwifi: rx: use new api to get band from rx mpdu (2019-10-18 11:52:49 +0300)
>
> ----------------------------------------------------------------
> Patches intended for v5.5
>
> * Revamp the debugging infrastructure;
> * Some udpdates to FW API commands;
> * Fix max amsdu value calculation;
> * Small updates in the debugging infra;
> * Some new helper functions;
> * A few clean-ups;
> * Other small fixes and improvements;
>
> ----------------------------------------------------------------

Every commit has a Change-id tag, please fix that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
