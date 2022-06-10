Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83758546C5B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiFJSah (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiFJSae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 14:30:34 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBA51CFD0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 11:30:29 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1654885827; bh=JvERuzfAbyVxQoZHSsN4ADrdU4w2H8qbe+kvh+06uFQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bMwAKq++iq/EwsWthB6rsBPeJCMZV46tTHq7cFbVdd+B4yQHaHsRBaqXCYsRuwr9R
         4x40rv2PMkP2Li6VTHJ1zqFj9qe26YbSJG4kTMpG5+RvwH3hmatJ0eTCIlvTtH/Ouq
         BR+XJLJdqTlY8VYrT0nRvl/eAZMaWfv+kH676oJTiYgizKfDMaUeulLOkOKDgMuRmt
         TZtkeofRTnmHQSFK3VG/GMPy3lFVIdWpcTWZZE/8ACPuPi37LMduyNoS2cx+2U8yEK
         jlv/sFHX58ZWC6wYxrSHt2jW/hy72+CstxW277cg+lBdD8YQymLl546xERNGz9DVDf
         3+NuoNv/1UhGA==
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     linux-wireless@vger.kernel.org,
        syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 1/2] ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
In-Reply-To: <2ee8f6fc-aec1-39a6-e8db-56e5e449ee8e@gmail.com>
References: <20220522041542.2911-1-hdanton@sina.com>
 <2ee8f6fc-aec1-39a6-e8db-56e5e449ee8e@gmail.com>
Date:   Fri, 10 Jun 2022 20:30:27 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pmjg2wxo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ This had the wrong mailing list in Cc, adding back linux-wireless ]

Pavel Skripkin <paskripkin@gmail.com> writes:
> Hi Hillf,
>
> On 5/22/22 07:15, Hillf Danton wrote:
>> 
>> In the call chain below
>> 
>> 	ath9k_hif_usb_firmware_cb()
>> 	  ath9k_htc_hw_alloc()
>> 	  ath9k_hif_usb_dev_init()
>> 	  ret = ath9k_htc_hw_init()
>> 	          ath9k_htc_probe_device()
>> 		    htc_handle->drv_priv = priv;
>> 		    ret = ath9k_htc_wait_for_target(priv);
>> 		    if (ret)
>> 			goto err_free;
>> 	  if (ret)
>> 		goto err_htc_hw_init;
>> 
>> err_free:
>> 	ieee80211_free_hw(hw);
>> 
>> 
>> err_htc_hw_init:
>> 	ath9k_hif_usb_dev_deinit(hif_dev);
>> 	  ath9k_hif_usb_dealloc_urbs()
>> err_dev_init:
>> 	ath9k_htc_hw_free(hif_dev->htc_handle);
>> err_dev_alloc:
>> 	release_firmware(fw);
>> err_fw:
>> 	ath9k_hif_usb_firmware_fail(hif_dev);
>> 
>> 
>> hw should survive deallocating urbs, and changes should be added instead to
>> the rollback in ath9k_htc_probe_device() by deferring cleanup of hw to its
>> callsite in addition to urbs.
>> 
>
> Don't get it, sorry. I am not changing the life time of `hw`, I am just 
> deferring htc_handle->drv_priv initialization.
>
>
>
>
> With regards,
> Pavel Skripkin
