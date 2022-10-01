Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E414C5F1C03
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Oct 2022 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJALom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Oct 2022 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJALol (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Oct 2022 07:44:41 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA06DDF
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7paJOERXZr9gpWv6Hoqqnji80Lwp5u+xWWySpJyrP6s=; b=TNZTwFnoNm2sOzqgTiCmdFBZLx
        2SvyVDMKesbhxwsexjrZUixyveCMV9S2pd0ZMopipUVAkyQRXWc7gl43gIQCd89r7L1fRmaPB3eJn
        xal9iYu+Lwy2hUVjLu3cuXTSeq9I6O5WqKlyMTjs6Ws95lXDUqtFGIBJ1BBxZPFEMYFk=;
Received: from p200300daa7301d00cc0df67a5b51dd3e.dip0.t-ipconnect.de ([2003:da:a730:1d00:cc0d:f67a:5b51:dd3e] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oeav5-009DLv-V6; Sat, 01 Oct 2022 13:44:36 +0200
Message-ID: <d67b5450-1f2b-63c1-8056-44fbe9737128@nbd.name>
Date:   Sat, 1 Oct 2022 13:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] wifi: mt76: mt7915: add two additional errors to
 ack-failure mask.
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20220929151526.9559-1-greearb@candelatech.com>
 <20220929151526.9559-2-greearb@candelatech.com>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220929151526.9559-2-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29.09.22 17:15, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> These other two bits also indicate tx failure as far as I can tell from
> reading the documents.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
The bits seem to have overlapping meaning, not sure if they always 
reliably indicate an error. I think we should leave this patch out, as 
it could potentially cause regressions.

- Felix
