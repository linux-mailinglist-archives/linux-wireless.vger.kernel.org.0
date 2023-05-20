Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DF70A72A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 May 2023 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjETK0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 May 2023 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjETK0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 May 2023 06:26:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEE189
        for <linux-wireless@vger.kernel.org>; Sat, 20 May 2023 03:26:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso41954665e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 20 May 2023 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684578398; x=1687170398;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vObmosUvKs40R6Nx0XFOqQk0+pz35f/Izx7DFZnJ6l8=;
        b=BdJdnW+n22oklwY48RyEoRJHRn/GtbVh4uupmEftjx8aD+Z/Umah0dH55qujQYNCH7
         UKWaj/RAdY7RRYILjf7QqhVKy4BrvN51+37vLOXrsN+QMtZ1zSi19UjfyblJaF2ccGbD
         hIu7f/m2gqLdEqXKiJhOg3s2PFg37I2BgjPYh7K53EOT7OrnvQNjS0Zhmnl8DaJmGKF+
         UJ5OsJrrCvzBqH6/Cr3pTw6O5ML6jMCBnlu956lV1UlyCg/RF6CePrg7gP64BuM++tnn
         Ab/ANZemHPNsEtERjr4/tutfGScjPbvjpF+J+uw8bYOdJseONDi+kxTeArTQw5J2Jqz1
         ZkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684578398; x=1687170398;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vObmosUvKs40R6Nx0XFOqQk0+pz35f/Izx7DFZnJ6l8=;
        b=TxWNsOksj3yofl8WWHNTFtXqjvL/ZcJ6B/azeYCisN2WaKAZ5JvXWyKvOhb0Be7hEQ
         WH5t8at3m48vwB4cTpL/OKvcEBY2iZCQ28zxLt6e2cBcd+yXUCe/hRujUzPjveNe55nu
         lNU3Wk41j+hL0oNTC9HBLymqxyUIYUF9NmWdmHEo+fzajcfCZ0+jvqxq2P9d9U+vmjvz
         sqd73PYpAkHBPA0OVin+BhCR0ZfLhNmqMu894z8fckwCZDDx9M5rM8MwYCQfQuJtdM87
         2ZGFT8ufhmqmeXmJEwVEv2MKx8IyCiwCy3GOqA/ufGQthpQROkPaWMvRvJrtnazogtMh
         n5Kw==
X-Gm-Message-State: AC+VfDzp5cbe8FPhk9tx+HjlmIgD64eYkJVc2FCCH1Gp9e2QUstX1Zs3
        OnZMJLfMj3zYFlG7iapNrz7oLQD3GRGQ+97PIeQ=
X-Google-Smtp-Source: ACHHUZ7QkCVcw17bIVMcySLvQglSLptYANW2Vmu3rQogw56AEh+n5ymtqbb3/5yCEjzlEDqbdEutgA==
X-Received: by 2002:adf:f6d1:0:b0:309:53ba:9703 with SMTP id y17-20020adff6d1000000b0030953ba9703mr3912447wrp.16.1684578397870;
        Sat, 20 May 2023 03:26:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d5190000000b003078c535277sm1525608wrv.91.2023.05.20.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 03:26:36 -0700 (PDT)
Date:   Sat, 20 May 2023 13:26:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     pozega.tomislav@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: rt2x00: add TX LOFT calibration for MT7620
Message-ID: <a5e29cc3-b56b-4233-94f6-0fb82b53dd61@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Tomislav Požega,

The patch dab902fe1d29: "wifi: rt2x00: add TX LOFT calibration for
MT7620" from Sep 17, 2022, leads to the following Smatch static
checker warning:

	drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9681 rt2800_loft_iq_calibration()
	warn: unsigned 'vga_gain[ch_idx]' is never less than zero.

drivers/net/wireless/ralink/rt2x00/rt2800lib.c
    9540 static void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
    9541 {
    9542         struct rf_reg_pair rf_store[CHAIN_NUM][13];
    9543         u32 macorg1 = 0;
    9544         u32 macorg2 = 0;
    9545         u32 macorg3 = 0;
    9546         u32 macorg4 = 0;
    9547         u32 macorg5 = 0;
    9548         u32 orig528 = 0;
    9549         u32 orig52c = 0;
    9550 
    9551         u32 savemacsysctrl = 0;
    9552         u32 macvalue = 0;
    9553         u32 mac13b8 = 0;
    9554         u32 p0 = 0, p1 = 0;
    9555         u32 p0_idx10 = 0, p1_idx10 = 0;
    9556 
    9557         u8 rfvalue;
    9558         u8 loft_dc_search_result[CHAIN_NUM][RF_ALC_NUM][2];
    9559         u8 ger[CHAIN_NUM], per[CHAIN_NUM];
    9560 
    9561         u8 vga_gain[] = {14, 14};
                 ^^^^^^^^^^^^^

    9562         u8 bbp = 0, ch_idx = 0, rf_alc_idx = 0, idx = 0;
    9563         u8 bbpr30, rfb0r39, rfb0r42;
    9564         u8 bbpr1;
    9565         u8 bbpr4;
    9566         u8 bbpr241, bbpr242;
    9567         u8 count_step;
    9568 
    9569         static const u8 rf_gain[] = {0x00, 0x01, 0x02, 0x04, 0x08, 0x0c};
    9570         static const u8 rfvga_gain_table[] = {0x24, 0x25, 0x26, 0x27, 0x28, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
    9571                                               0x31, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3F};
    9572         static const u8 bbp_2324gain[] = {0x16, 0x14, 0x12, 0x10, 0x0c, 0x08};
    9573 
    9574         savemacsysctrl = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
    9575         macorg1 = rt2800_register_read(rt2x00dev, TX_PIN_CFG);
    9576         macorg2 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
    9577         macorg3 = rt2800_register_read(rt2x00dev, RF_BYPASS0);
    9578         macorg4 = rt2800_register_read(rt2x00dev, RF_CONTROL3);
    9579         macorg5 = rt2800_register_read(rt2x00dev, RF_BYPASS3);
    9580         mac13b8 = rt2800_register_read(rt2x00dev, 0x13b8);
    9581         orig528 = rt2800_register_read(rt2x00dev, RF_CONTROL2);
    9582         orig52c = rt2800_register_read(rt2x00dev, RF_BYPASS2);
    9583 
    9584         macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
    9585         macvalue &= (~0x04);
    9586         rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
    9587 
    9588         if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_TX)))
    9589                 rt2x00_warn(rt2x00dev, "RF TX busy in LOFT IQ calibration\n");
    9590 
    9591         macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
    9592         macvalue &= (~0x08);
    9593         rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
    9594 
    9595         if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_RX)))
    9596                 rt2x00_warn(rt2x00dev, "RF RX busy in LOFT IQ calibration\n");
    9597 
    9598         for (ch_idx = 0; ch_idx < 2; ch_idx++)
    9599                 rt2800_rf_configstore(rt2x00dev, rf_store, ch_idx);
    9600 
    9601         bbpr30 = rt2800_bbp_read(rt2x00dev, 30);
    9602         rfb0r39 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 39);
    9603         rfb0r42 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 42);
    9604 
    9605         rt2800_bbp_write(rt2x00dev, 30, 0x1F);
    9606         rt2800_rfcsr_write_bank(rt2x00dev, 0, 39, 0x80);
    9607         rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, 0x5B);
    9608 
    9609         rt2800_bbp_write(rt2x00dev, 23, 0x00);
    9610         rt2800_bbp_write(rt2x00dev, 24, 0x00);
    9611 
    9612         rt2800_setbbptonegenerator(rt2x00dev);
    9613 
    9614         for (ch_idx = 0; ch_idx < 2; ch_idx++) {
    9615                 rt2800_bbp_write(rt2x00dev, 23, 0x00);
    9616                 rt2800_bbp_write(rt2x00dev, 24, 0x00);
    9617                 rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x00);
    9618                 rt2800_register_write(rt2x00dev, TX_PIN_CFG, 0x0000000F);
    9619                 rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00000004);
    9620                 rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x00003306);
    9621                 rt2800_register_write(rt2x00dev, 0x13b8, 0x10);
    9622                 udelay(1);
    9623 
    9624                 if (ch_idx == 0)
    9625                         rt2800_rf_aux_tx0_loopback(rt2x00dev);
    9626                 else
    9627                         rt2800_rf_aux_tx1_loopback(rt2x00dev);
    9628 
    9629                 udelay(1);
    9630 
    9631                 if (ch_idx == 0)
    9632                         rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00001004);
    9633                 else
    9634                         rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00002004);
    9635 
    9636                 rt2800_bbp_write(rt2x00dev, 158, 0x05);
    9637                 rt2800_bbp_write(rt2x00dev, 159, 0x00);
    9638 
    9639                 rt2800_bbp_write(rt2x00dev, 158, 0x01);
    9640                 if (ch_idx == 0)
    9641                         rt2800_bbp_write(rt2x00dev, 159, 0x00);
    9642                 else
    9643                         rt2800_bbp_write(rt2x00dev, 159, 0x01);
    9644 
    9645                 vga_gain[ch_idx] = 18;
                                            ^^

    9646                 for (rf_alc_idx = 0; rf_alc_idx < 3; rf_alc_idx++) {
    9647                         rt2800_bbp_write(rt2x00dev, 23, bbp_2324gain[rf_alc_idx]);
    9648                         rt2800_bbp_write(rt2x00dev, 24, bbp_2324gain[rf_alc_idx]);
    9649 
    9650                         macvalue = rt2800_register_read(rt2x00dev, RF_CONTROL3);
    9651                         macvalue &= (~0x0000F1F1);
    9652                         macvalue |= (rf_gain[rf_alc_idx] << 4);
    9653                         macvalue |= (rf_gain[rf_alc_idx] << 12);
    9654                         rt2800_register_write(rt2x00dev, RF_CONTROL3, macvalue);
    9655                         macvalue = (0x0000F1F1);
    9656                         rt2800_register_write(rt2x00dev, RF_BYPASS3, macvalue);
    9657 
    9658                         if (rf_alc_idx == 0) {
    9659                                 rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x21);
    9660                                 for (; vga_gain[ch_idx] > 0;
    9661                                      vga_gain[ch_idx] = vga_gain[ch_idx] - 2) {
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
18 is an even number so this can't actually underflow.


    9662                                         rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
    9663                                         rt2800_rfcsr_write_dccal(rt2x00dev, 3, rfvalue);
    9664                                         rt2800_rfcsr_write_dccal(rt2x00dev, 4, rfvalue);
    9665                                         rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x00);
    9666                                         rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x00);
    9667                                         p0 = rt2800_do_fft_accumulation(rt2x00dev, 0x0A, 0);
    9668                                         rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x21);
    9669                                         p1 = rt2800_do_fft_accumulation(rt2x00dev, 0x0A, 0);
    9670                                         rt2x00_dbg(rt2x00dev, "LOFT AGC %d %d\n", p0, p1);
    9671                                         if ((p0 < 7000 * 7000) && (p1 < (7000 * 7000)))
    9672                                                 break;
    9673                                 }
    9674 
    9675                                 rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x00);
    9676                                 rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x00);
    9677 
    9678                                 rt2x00_dbg(rt2x00dev, "Used VGA %d %x\n", vga_gain[ch_idx],
    9679                                            rfvga_gain_table[vga_gain[ch_idx]]);
    9680 
--> 9681                                 if (vga_gain[ch_idx] < 0)
                                             ^^^^^^^^^^^^^^^^^^^^
But if it could then this test would not work because the type is u8.

    9682                                         vga_gain[ch_idx] = 0;
    9683                         }
    9684 
    9685                         rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
    9686 
    9687                         rt2800_rfcsr_write_dccal(rt2x00dev, 3, rfvalue);
    9688                         rt2800_rfcsr_write_dccal(rt2x00dev, 4, rfvalue);
    9689 
    9690                         rt2800_loft_search(rt2x00dev, ch_idx, rf_alc_idx, loft_dc_search_result);
    9691                 }
    9692         }

regards,
dan carpenter
