Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF46D3FE7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDCJPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjDCJPc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 05:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAFEC62
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 02:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C0A6170B
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 09:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E820BC433D2;
        Mon,  3 Apr 2023 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680513318;
        bh=BVHiaqZpCtLErDvmtIzfl4mTYGJjwXmDlcErnLadaxk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jr+L7EyRSikbGYpRta4fBY0N5qQ2Wi5PUj6GCOF9ADLd8r3JKx/QankHEx8cRw3qi
         JMUwVTGwgbY2Cmp4TrYgBHdEEvqOimwowz3AVOZVCp4I+Z+H1YXQDtM/rwQHSVYzqD
         Y8mNtPcjSgJZs/e+wLoFEe3k7ghYvdOJu5oq8KDQIHtp4DnrG6Qd0KlvdTVJMU+pAw
         QGfi/WTUeSDuipgQWR3GvoLROMwgGStOLGB/4V+zaeJ35+P3QKaMXs1FF4pBRmT61R
         KGgCY5y4pc/uft4Trvg8b9MQCcAbkL6XTESn1oaYshTfbI9y/2UJObNPl/+DeWGRVO
         9lORJbdUuMLkw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH V2 0/2] wifi: ath11k: bug fixes in tx encap offload and ppdu stats
References: <20230401024932.11722-1-quic_pradeepc@quicinc.com>
Date:   Mon, 03 Apr 2023 12:15:12 +0300
In-Reply-To: <20230401024932.11722-1-quic_pradeepc@quicinc.com> (Pradeep Kumar
        Chitrapu's message of "Fri, 31 Mar 2023 19:49:30 -0700")
Message-ID: <87edp1ba3j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

> Fixes bugs in radiotap fields and tx status reporting in TX
> encapsulation offload cases.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Pradeep Kumar Chitrapu (2):
>   wifi: ath11k: fix tx status reporting in encap offload mode
>   wifi: ath11k: Fix incorrect update of radiotap fields

No changelog. What has changed since v1?


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
