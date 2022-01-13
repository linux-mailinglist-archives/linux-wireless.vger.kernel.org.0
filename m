Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F148D5FD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiAMKri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 05:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiAMKrh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 05:47:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD369C06173F
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 02:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6976AB82248
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 10:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30502C36AE3;
        Thu, 13 Jan 2022 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642070855;
        bh=FPds3QceaWI8Z25hIqdBoVUbjVTiitOvWfTy5ub+GHc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AcyikCFt3orVYyuHS098N2CUYWJ7im+6xHiu2a+sqCgmCd8lhhEMunL9iJuzV6qhS
         aWGLbAdW5QEef2V3AA4+Z6Fp4MZMFQF2jX6GvxbAPiwjfWczqKdGgukxzLUzx9jRoI
         OBOKjcRok4DKZkvZypkM7DVpCX+lbKV1zIoAHxqLGpXUKj6P2o0zPstUkuMDdNP2rA
         AXORC675IDABLIU17KaI3SRR9IU0EkPdDmVqqsmPxfd0yt/jU9pr3+VSUQhh1kojup
         J4O5b7vuqMIgTUVZfWjKiRuBhl+B/KIeVCEXqOawkvIMg5D69H/NPwYz3O1HMuBacD
         4uRHhmNpgWjSA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, lenb@kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH] iwlwifi: mvm: check if SAR GEO is supported before sending command
References: <iwlwifi.20220113104217.0ae07c2712dc.I14e2985bfd7ddd8a8d83eb1869b800c0e7f30db4@changeid>
Date:   Thu, 13 Jan 2022 12:47:32 +0200
In-Reply-To: <iwlwifi.20220113104217.0ae07c2712dc.I14e2985bfd7ddd8a8d83eb1869b800c0e7f30db4@changeid>
        (Luca Coelho's message of "Thu, 13 Jan 2022 10:42:40 +0200")
Message-ID: <87bl0fud2z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> Older hardware, for instance 3160, do not support SAR GEO offsets.  We
> used to check for support before sending the command, but when moving
> the command to the init phase, we lost the check.  This causes a
> failure when initializing HW that do not support this command.
>
> Fix that by adding a check before sending the command.  Additionally,
> fix the caller so that it checks for the return value of the
> iwl_mvm_sar_geo_init() function, which it was ignoring.
>
> Fixes: db700bc35703 ("iwlwifi: mvm: check if SAR GEO is supported before sending command")

$ git show db700bc35703
fatal: ambiguous argument 'db700bc35703': unknown revision or path not in the working tree.

No need to resend because of this, if you can provide the commit id I
can fix the tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
