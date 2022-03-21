Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703E4E2551
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbiCULie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiCULic (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 07:38:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90AB2478
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76512B81269
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 11:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D60C340E8;
        Mon, 21 Mar 2022 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647862624;
        bh=PaASJY+h4nIV4WWZGWDHE04GtTCVUpLBUwvWYidELRg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a1yhIgYx67i/n4B+GRey7oXrtayTHvljIR70wVp3n3SkrkekGXUCydvSDDM0ObHne
         GUNlvzjcsT4RvOY8WCPiOkrJuj9BX5aXc/CCmsNaDuXyckuFbDEs5ZHF1ow10/ewma
         OpF1IhDAZ1+m1zPHicWAv2YsJV5u+cgvxvq4CrRBlmvs8oX9O5HxKNUjpMHECXa5Et
         husoFjeB4GiEFjXIXgLxBDD94/0z/JHxU/g3j1cAXxH29vFKsbDD9Ste008ql0fUxh
         1W0ygOCmubp0+LlxQX84Pp7A5V6Ifba1AdoFOrIpdENwiPe8gi/LKv6Ty9x8tafP+6
         YQP1bb+gR15bw==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Daniel.Shen@infineon.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: Add support for SAR
References: <20220321022231.268197-1-quic_bqiang@quicinc.com>
        <164785670143.6138.10862194405307750688.kvalo@kernel.org>
        <af9924aaa82b4622bee872c47fdf88a8@infineon.com>
Date:   Mon, 21 Mar 2022 13:36:59 +0200
In-Reply-To: <af9924aaa82b4622bee872c47fdf88a8@infineon.com> (Daniel Shen's
        message of "Mon, 21 Mar 2022 11:29:14 +0000")
Message-ID: <87lex3mt9g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Daniel.Shen@infineon.com> writes:

> I think I am not the right person you would like to send this email.
> Please check it, I received a great many of emails. 

ath11k and linux-wireless are public mailing lists, at some point you
must have subscribed yourself to either of the lists. If you don't want
to be part of the list you can unsubscribe by your own. I'm guessing you
are in ath11k list so for that list you can unsubscribe here:

http://lists.infradead.org/mailman/listinfo/ath11k

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
