Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46E6BADA0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCOK12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCOK12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 06:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FB64850
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 03:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE2561CB0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 10:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4512C433EF;
        Wed, 15 Mar 2023 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678876045;
        bh=Y6n/TXu8hh1tM4ooccAelO2vPTAVs6rYcU/FOUxJd2Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AbW51TSNj/x02XvINBt9ghexqeg5sfuiETPhUxzEHLcEE2U4GIWQaJPzoienCR4+4
         pMkPl8JeED9gA97FRULajBOvZW2iip2ivUx1j6AKiEcRRThd8HZlFZg2DuOS+R3qN+
         oU0p/SkGH/5WVL96wqsJ+KAWwi/F5S9OjNKgaLi+wxpAUMEiYeXn5g+DX60lAGQQ0T
         RnvDnzctLnUdqabnF4Y50QaftMFYHwhZD3zI/5qeXfrIVaFtgrztPsax1MaD36y+M3
         xpwmEZmXI4rNCfWmJ/sZwin4mo0rFZNAmj/VC6JX3fAkP3TlGOScKvj7lK5hhQcQqe
         aGY+2mJELQ4Sg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath11k: Fix incorrect update of BCC counters in peer stats
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
        <20230308174703.12270-3-quic_pradeepc@quicinc.com>
Date:   Wed, 15 Mar 2023 12:27:21 +0200
In-Reply-To: <20230308174703.12270-3-quic_pradeepc@quicinc.com> (Pradeep Kumar
        Chitrapu's message of "Wed, 8 Mar 2023 09:47:03 -0800")
Message-ID: <87mt4emhrq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

> Fix typos causing incorrect update of BCC counters in 11ax mode.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

What are BCC counters?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
