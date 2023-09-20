Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271A7A837D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjITNei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjITNeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:34:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DDAB
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:34:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58765C433C8;
        Wed, 20 Sep 2023 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216870;
        bh=kVDWaUupyJsjXdNWOC1wPRQydQz5BbV+lMqJ1V1rEZU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HoR6aqQAwX1Q4jXYdNNxxipldr68seu5mLVSfeh5gn0d3MrRhyZDev66iBd8j1LDX
         VoQqYbN/kMxcCMg/CiKuFY9FxE4118RUyQ0lj48MU04AwcCdmi/+6Q9i+xSWt7U8fP
         KKmldqFdeRy3QHHe4KFk1RvNrYeztVudE2qfeRmLI3PP3OTDr4CldnsLGBmvQN9xYR
         SDlpfNp9HsnE5GFqSS8eEx6rqG5fohRXm39xTPVEDLh/2Jd5Svby+JGfy6fteFKsGy
         r14v25PzhxoOo08dQwrcHLbMfXVnIn6QbCQ7oXdZLcmFAiuwws+Chvx9mvIFcLqSoA
         aQL3tTCaEtZew==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Aishwarya R (QUIC)" <quic_aisr@quicinc.com>
Cc:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Wen Gong (QUIC)" <quic_wgong@quicinc.com>
Subject: Re: [PATCH 1/7] wifi: ath12k: add support to select 6 GHz
 Regulatory type
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
        <20230919071724.15505-2-quic_aisr@quicinc.com>
        <4282f92a-3543-4863-bc00-478ae03759e0@quicinc.com>
        <0a83690159fa452b9e7c0ebb3f751b55@quicinc.com>
Date:   Wed, 20 Sep 2023 16:34:27 +0300
In-Reply-To: <0a83690159fa452b9e7c0ebb3f751b55@quicinc.com> (Aishwarya R.'s
        message of "Wed, 20 Sep 2023 05:48:27 +0000")
Message-ID: <87zg1h9dek.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Aishwarya R (QUIC)" <quic_aisr@quicinc.com> writes:

[deleting ~500 lines of unnecessary quotes]

> Thanks for your review. I will address all your comments in next revision.

Please edit your quotes and only include the necessary information in
your reply. These kind of huge mails make use of patchwork very
difficult:

https://patchwork.kernel.org/project/linux-wireless/patch/20230919071724.15505-2-quic_aisr@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
