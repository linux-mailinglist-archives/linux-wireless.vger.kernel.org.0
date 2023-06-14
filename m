Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC853730424
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbjFNPsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFNPsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 11:48:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E5106;
        Wed, 14 Jun 2023 08:48:39 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9Sjc-0007ll-RE; Wed, 14 Jun 2023 17:48:36 +0200
Message-ID: <bcc789b8-2f4e-365d-4f05-9d578517560e@leemhuis.info>
Date:   Wed, 14 Jun 2023 17:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [iwlwifi] 6.3 regression, AX201 crash on traffic activity with
 Pixel 7, bisected
Content-Language: en-US, de-DE
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        evgeny nikiforov <evgeny.niki4off@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Golan Ben Ami <golan.ben.ami@intel.com>
References: <CAPrf5XXD8COh6DK9s41uvgJ5V57nenUQVeb1f=cFVqaWDN++dA@mail.gmail.com>
 <86b8e66e2df6e46d2102bda470a82a8a40fa84fe.camel@intel.com>
 <9300def5-2319-eeff-55d2-f67da3ff0bae@leemhuis.info>
 <f67f0e72-b507-7874-b693-32cf3954ed4a@leemhuis.info>
 <CAPrf5XXJ58aAmP6P65QhatirQJ+vHLrWDr-MiMr3eS3=JGCALA@mail.gmail.com>
 <8717437c-e05d-4aa0-6dd4-a82105f339f9@leemhuis.info>
 <CAPrf5XUF+KrE9DzwomPufgtE_27AhFdG5DF-c=bDMv2ObMYtow@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPrf5XUF+KrE9DzwomPufgtE_27AhFdG5DF-c=bDMv2ObMYtow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686757719;87fe3b7a;
X-HE-SMSGID: 1q9Sjc-0007ll-RE
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.06.23 22:12, evgeny nikiforov wrote:
> bisecting results in following:
> crash behavior happened on this commit with switch fw from 72 to 74:
> linux 6.3: 9ad1e7e5b0c488e4518edd698238a87ac6a73caa wifi: iwlwifi:
> bump FW API to 74 for AX devices
> crash not reproduced after this commit on switch fw from 75 to 77:
> linux 6.4: ef3ed33dfc8f0f1c81ca103e6b68b4f77ee0ab65 wifi: iwlwifi:
> bump FW API to 77 for AX devices

Thx for this, but I guess that sadly doesn't bring us any closer, as
those commits likely hide the real culprit/fix.

Sadly the Intel wireless developer seem to ignore this report. That is
really unfortunate. :-(

I wonder if I should escalate this to higher authorities. But OTOH: 6.3
will be EOL in about a month anyway, so maybe that's not worth it.

Evgeny, what do you think? Are you maybe willing to run 6.4-rc now and
ignore this, as this apparently is an issue that only bothers you?

Cioa, Thorsten

> On Mon, 5 Jun 2023 at 23:05, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> CCing Golan Ben Ami <golan.ben.ami@intel.com>, who authored the culprit
>>
>> On 05.06.23 18:34, evgeny nikiforov wrote:
>>> Hi, the problem is still reproducible on linux 6.3.6, and as I
>>> mentioned on bugzilla, mainline 6.4rc1 works normally.
>>
>> Ahh, great, thx. And sorry, had missed that in the flood of regressions
>> reports I have to deal with.
>>
>> Golan Ben Ami: do you maybe have an idea what might cause evgeny's problems?
>>
>> Evgeny, btw: one way to fix this would be a bisection between 6.3 and
>> 6.4-rc1 to find the change that resolves your problem. But maybe the
>> developers have an idea that makes this unnecessary.
>>
>> Ciao, Thorsten
>>
>>> On Mon, 5 Jun 2023 at 16:11, Thorsten Leemhuis
>>> <regressions@leemhuis.info> wrote:
>>>>
>>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>>> for once, to make this easily accessible to everyone.
>>>>
>>>> Nothing has happened here for a while. That's unfourtunate. Guess that
>>>> means I need to bring higher level maintainers into the loop to chime
>>>> in. But before I do that a quick question for Evgeny:
>>>>
>>>> Does the problem still happen with latest mainline?
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>
>>>> #regzbot poke
>>>>
>>>> On 17.05.23 18:16, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>>>> for once, to make this easily accessible to everyone.
>>>>>
>>>>> This looks stalled.
>>>>>
>>>>> Gregory, Evgeny afaics provided some of the data you asked for here:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=217419
>>>>>
>>>>> But then afaics nothing happened anymore. Or was progress made and I
>>>>> just missed it?
>>>>>
>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>> --
>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>> If I did something stupid, please tell me, as explained on that page.
>>>>>
>>>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=217419
>>>>> #regzbot poke
>>>>>
>>>>>
>>>>> On 07.05.23 14:35, Greenman, Gregory wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, 2023-05-05 at 02:29 +0500, evgeny nikiforov wrote:
>>>>>>> Hello
>>>>>>> I have a laptop with Intel Wi-Fi 6 AX201.
>>>>>>> After updating from 6.2 to 6.3, I'm experiencing wifi crashes, wifi
>>>>>>> restart when traffic is flowing with Pixel 7 Pro (wifi 6E/802.11ax).
>>>>>>> Other older wifi devices probably not affected (tried Xiaomi pad with
>>>>>>> wifi 5/802.11ac).
>>>>>>> Tested with iperf3 in both directions, rsyncing Pixel photos to
>>>>>>> laptop, via router (wifi 5) or via Pixel wifi hotspot.
>>>>>>> The whole system freezes for seconds, no cursor movements possible at
>>>>>>> these moments (libinput "Touch jump detected and discarded" in logs
>>>>>>> indicating this).
>>>>>>> No problem with the 6.2 kernel.
>>>>>>>
>>>>>>> Bisecting leads to this commit of bumping FW API to 74
>>>>>>> 9ad1e7e5b0c488e4518edd698238a87ac6a73caa,
>>>>>>> looking strange to me, but reverting from 74 to 72 in 6.3 indeed
>>>>>>> successful with no crash.
>>>>>>>
>>>>>>> May 05 00:58:55 wpa_supplicant[862]: TDLS: Creating peer entry for
>>>>>>> ca:0e:48:5e:0d:f2
>>>>>>> May 05 00:58:56 wpa_supplicant[862]: TDLS: Dialog Token in TPK M1 88
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Error sending ADD_STA:
>>>>>>> time out after 2000ms.
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Current CMD queue
>>>>>>> read_ptr 222 write_ptr 223
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Transport status:
>>>>>>> 0x0000004A, valid: 6
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Loaded firmware version:
>>>>>>> 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000084 |
>>>>>>> NMI_INTERRUPT_UNKNOWN
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x004CC44C | branchlink2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00008A7E | interruptlink1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00008A7E | interruptlink2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x004C402C | data1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x01000000 | data2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | data3
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x98001858 | beacon time
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x36EE67BE | tsf low
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | time gp1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0A2DDA07 | time gp2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0000004A | uCode version major
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0xA5E9588B | uCode version minor
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000351 | hw version
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x18C89001 | board version
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x80FAFD0B | hcmd
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00020000 | isr0
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | isr1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x28F04002 | isr2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00C3030C | isr3
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | isr4
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x04D2001C | last cmd Id
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x004C402C | wait_event
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | timestamp
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00008854 | flow_handler
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Transport status:
>>>>>>> 0x0000004A, valid: 7
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x80456052 | umac branchlink2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x804725A6 | umac interruptlink1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x804658FE | umac interruptlink2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x01000000 | umac data1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x804658FE | umac data2
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000000 | umac data3
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0000004A | umac major
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0xA5E9588B | umac minor
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0A2DDA05 | frame pointer
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0xC0887EB0 | stack pointer
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00DE0118 | last host cmd
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00004008 | isr status reg
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: IML/ROM dump:
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00005799 | IML/ROM data1
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM
>>>>>>> WFPM_AUTH_KEY_0
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: Fseq Registers:
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x60000041 | FSEQ_ERROR_CODE
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_TOP_INIT_VERSION
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00090006 |
>>>>>>> FSEQ_CNVIO_INIT_VERSION
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x00000003 |
>>>>>>> FSEQ_TOP_CONTENT_VERSION
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x05B0905B |
>>>>>>> CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: 0x0000025B |
>>>>>>> CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
>>>>>>> May 05 00:58:58 kernel: iwlwifi 0000:00:14.3: WRT: Collecting data:
>>>>>>> ini trigger 4 fired (delay=0ms).
>>>>>>> May 05 00:58:58 kernel: ieee80211 phy0: Hardware restart was requested
>>>>>>> May 05 00:59:00 gnome-shell[1450]: libinput error: event10 -
>>>>>>> MSFT0004:00 06CB:CE2D Touchpad: kernel bug: Touch jump detected and
>>>>>>> discarded.
>>>>>>> May 05 00:59:00 gnome-shell[1450]: See
>>>>>>> https://wayland.freedesktop.org/libinput/doc/1.23.0/touchpad-jumping-cursors.html
>>>>>>> for details
>>>>>>> May 05 00:59:02 kernel: ------------[ cut here ]------------
>>>>>>> May 05 00:59:02 kernel: WARNING: CPU: 2 PID: 862 at
>>>>>>> drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1362
>>>>>>> iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
>>>>>>> May 05 00:59:02 kernel: Modules linked in: ccm snd_seq_dummy
>>>>>>> snd_hrtimer snd_seq rfcomm snd_seq_device cmac algif_hash
>>>>>>> algif_skcipher af_alg bridge stp llc bnep
>>>>>>> snd_ctl_led snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common
>>>>>>> snd_sof_probes snd_soc_hdac_hdmi hid_sensor_prox hid_sensor_trigger
>>>>>>> industrialio_triggered_buffer
>>>>>>> hid_sensor_iio_common kfifo_buf industrialio hid_sensor_custom
>>>>>>> hid_sensor_hub intel_ishtp_hid vfat fat snd_hda_codec_hdmi
>>>>>>> snd_hda_codec_realtek
>>>>>>> snd_hda_codec_generic iwlmvm ledtrig_audio snd_soc_dmic
>>>>>>> snd_sof_pci_intel_tgl snd_sof_intel_hda_common btusb btrtl
>>>>>>> snd_soc_hdac_hda btbcm snd_sof_pci btintel
>>>>>>> snd_sof_xtensa_dsp joydev btmtk mousedev snd_sof_intel_hda mac80211
>>>>>>> bluetooth snd_sof snd_sof_utils snd_hda_ext_core
>>>>>>> snd_soc_acpi_intel_match snd_soc_acpi crc16
>>>>>>> uvcvideo ecdh_generic snd_soc_core videobuf2_vmalloc videobuf2_memops
>>>>>>> snd_compress uvc videobuf2_v4l2 snd_hda_intel videodev
>>>>>>> snd_intel_dspcfg snd_hda_codec
>>>>>>> iTCO_wdt hid_multitouch x86_pkg_temp_thermal intel_pmc_bxt
>>>>>>> intel_powerclamp coretemp kvm_intel
>>>>>>> May 05 00:59:02 kernel:  videobuf2_common mc libarc4 kvm iwlwifi
>>>>>>> mei_pxp mei_hdcp iTCO_vendor_support pmt_telemetry intel_rapl_msr
>>>>>>> snd_hwdep irqbypass pmt_class
>>>>>>> snd_hda_core rapl snd_pcm intel_cstate snd_timer cfg80211 intel_uncore
>>>>>>> spi_nor processor_thermal_device_pci_legacy pcspkr snd mei_me
>>>>>>> ucsi_acpi
>>>>>>> intel_soc_dts_iosf intel_ish_ipc processor_thermal_device
>>>>>>> processor_thermal_rfim typec_ucsi mtd intel_lpss_pci i2c_i801
>>>>>>> processor_thermal_mbox intel_lpss roles
>>>>>>> i2c_smbus mei soundcore wmi_bmof processor_thermal_rapl idma64
>>>>>>> intel_vsec typec intel_ishtp intel_rapl_common i2c_hid_acpi igen6_edac
>>>>>>> ideapad_laptop i2c_hid
>>>>>>> platform_profile rfkill int3403_thermal int340x_thermal_zone intel_hid
>>>>>>> int3400_thermal acpi_thermal_rel sparse_keymap acpi_pad mac_hid
>>>>>>> usbip_host usbip_core
>>>>>>> pkcs8_key_parser dm_multipath sg fuse crypto_user loop zram ip_tables
>>>>>>> x_tables dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_mod
>>>>>>> sdhci_pci cqhci
>>>>>>> crct10dif_pclmul crc32_pclmul sdhci polyval_clmulni polyval_generic
>>>>>>> nvme serio_raw mmc_core gf128mul atkbd
>>>>>>> May 05 00:59:02 kernel:  ghash_clmulni_intel libps2 sha512_ssse3
>>>>>>> vivaldi_fmap nvme_core aesni_intel crypto_simd i8042 cryptd xhci_pci
>>>>>>> spi_intel_pci spi_intel
>>>>>>> nvme_common xhci_pci_renesas serio i915 i2c_algo_bit drm_buddy
>>>>>>> intel_gtt video wmi drm_display_helper cec ttm btrfs blake2b_generic
>>>>>>> xor raid6_pq libcrc32c
>>>>>>> crc32c_generic crc32c_intel
>>>>>>> May 05 00:59:02 kernel: CPU: 2 PID: 862 Comm: wpa_supplicant Not
>>>>>>> tainted 6.3.1 #46 872b0abba9595f0d8ed586113c455b0be8334e0d
>>>>>>> May 05 00:59:02 kernel: Hardware name: LENOVO 82L3/LNVNB161216, BIOS
>>>>>>> GDCN63WW(V2.08) 09/26/2022
>>>>>>> May 05 00:59:02 kernel: RIP:
>>>>>>> 0010:iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
>>>>>>> May 05 00:59:02 kernel: Code: c3 28 4c 39 eb 75 b4 31 c0 5b 5d 41 5c
>>>>>>> 41 5d 41 5e c3 cc cc cc cc 0f 0b b8 f4 fd ff ff 5b 5d 41 5c 41 5d 41
>>>>>>> 5e c3 cc cc cc cc <0f>
>>>>>>> 0b 48 8b 7f 40 48 c7 c1 40 fb 96 c1 48 c7 c2 2e 00 98 c1 31 f6
>>>>>>> May 05 00:59:02 kernel: RSP: 0018:ffffb4e74472f7a8 EFLAGS: 00010293
>>>>>>> May 05 00:59:02 kernel: RAX: ffffffffc141d6d0 RBX: ffffa04dc5ff6d10
>>>>>>> RCX: ffffa04dc6b220c8
>>>>>>> May 05 00:59:02 kernel: RDX: 0000000000000001 RSI: 0000000000000004
>>>>>>> RDI: ffffa04dc30e0028
>>>>>>> May 05 00:59:02 kernel: RBP: 0000000000000004 R08: 0000000000000000
>>>>>>> R09: 0000000000000000
>>>>>>> May 05 00:59:02 kernel: R10: 0000000000000001 R11: 0000000000000100
>>>>>>> R12: ffffa04dc5ff6cfc
>>>>>>> May 05 00:59:02 kernel: R13: ffffa04dc5ff6e78 R14: ffffa04dc6b22088
>>>>>>> R15: 0000000000000000
>>>>>>> May 05 00:59:02 kernel: FS:  00007fa743655ec0(0000)
>>>>>>> GS:ffffa0512fa80000(0000) knlGS:0000000000000000
>>>>>>> May 05 00:59:02 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> May 05 00:59:02 kernel: CR2: 000055665036a000 CR3: 0000000108e2e006
>>>>>>> CR4: 0000000000f70ee0
>>>>>>> May 05 00:59:02 kernel: PKRU: 55555554
>>>>>>> May 05 00:59:02 kernel: Call Trace:
>>>>>>> May 05 00:59:02 kernel:  <TASK>
>>>>>>> May 05 00:59:02 kernel:  iwl_mvm_mac_flush+0x182/0x2e0 [iwlmvm
>>>>>>> 6d10fca3210c7a35f49263fea34411a52b4718fd]
>>>>>>> May 05 00:59:02 kernel:  __ieee80211_flush_queues+0xaf/0x250 [mac80211
>>>>>>> fdf58da67d59aa11fd56ae8c66d9a6051a561028]
>>>>>>> May 05 00:59:02 kernel:  ieee80211_tdls_mgmt+0x104/0x420 [mac80211
>>>>>>> fdf58da67d59aa11fd56ae8c66d9a6051a561028]
>>>>>>> May 05 00:59:02 kernel:  nl80211_tdls_mgmt+0x110/0x210 [cfg80211
>>>>>>> 60e8cee0162d4fb4509cf55476b07c3f6e97646f]
>>>>>>> May 05 00:59:02 kernel:  genl_family_rcv_msg_doit.isra.0+0xe3/0x140
>>>>>>> May 05 00:59:02 kernel:  genl_rcv_msg+0x1b6/0x2c0
>>>>>>> May 05 00:59:02 kernel:  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211
>>>>>>> 60e8cee0162d4fb4509cf55476b07c3f6e97646f]
>>>>>>> May 05 00:59:02 kernel:  ? __pfx_nl80211_tdls_mgmt+0x10/0x10 [cfg80211
>>>>>>> 60e8cee0162d4fb4509cf55476b07c3f6e97646f]
>>>>>>> May 05 00:59:02 kernel:  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211
>>>>>>> 60e8cee0162d4fb4509cf55476b07c3f6e97646f]
>>>>>>> May 05 00:59:02 kernel:  ? __pfx_genl_rcv_msg+0x10/0x10
>>>>>>> May 05 00:59:02 kernel:  netlink_rcv_skb+0x58/0x110
>>>>>>> May 05 00:59:02 kernel:  genl_rcv+0x28/0x40
>>>>>>> May 05 00:59:02 kernel:  netlink_unicast+0x19e/0x290
>>>>>>> May 05 00:59:02 kernel:  netlink_sendmsg+0x254/0x4d0
>>>>>>> May 05 00:59:02 kernel:  sock_sendmsg+0x93/0xa0
>>>>>>> May 05 00:59:02 kernel:  ____sys_sendmsg+0x27d/0x310
>>>>>>> May 05 00:59:02 kernel:  ? copy_msghdr_from_user+0x7d/0xc0
>>>>>>> May 05 00:59:02 kernel:  ___sys_sendmsg+0x9a/0xe0
>>>>>>> May 05 00:59:02 kernel:  __sys_sendmsg+0x7a/0xd0
>>>>>>> May 05 00:59:02 kernel:  do_syscall_64+0x5c/0x90
>>>>>>> May 05 00:59:02 kernel:  ? do_syscall_64+0x6b/0x90
>>>>>>> May 05 00:59:02 kernel:  ? _copy_from_user+0x4a/0x60
>>>>>>> May 05 00:59:02 kernel:  ? netlink_setsockopt+0x323/0x4a0
>>>>>>> May 05 00:59:02 kernel:  ? __sys_setsockopt+0xf2/0x1d0
>>>>>>> May 05 00:59:02 kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
>>>>>>> May 05 00:59:02 kernel:  ? do_syscall_64+0x6b/0x90
>>>>>>> May 05 00:59:02 kernel:  ? do_syscall_64+0x6b/0x90
>>>>>>> May 05 00:59:02 kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
>>>>>>> May 05 00:59:02 kernel:  ? do_syscall_64+0x6b/0x90
>>>>>>> May 05 00:59:02 kernel:  ? do_syscall_64+0x6b/0x90
>>>>>>> May 05 00:59:02 kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>>> May 05 00:59:02 kernel: RIP: 0033:0x7fa743122e64
>>>>>>> May 05 00:59:02 kernel: Code: 15 f9 de 0c 00 f7 d8 64 89 02 48 c7 c0
>>>>>>> ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 9d 66 0d 00 00 74 13 b8
>>>>>>> 2e 00 00 00 0f 05 <48>
>>>>>>> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
>>>>>>> May 05 00:59:02 kernel: RSP: 002b:00007ffc48fa8da8 EFLAGS: 00000202
>>>>>>> ORIG_RAX: 000000000000002e
>>>>>>> May 05 00:59:02 kernel: RAX: ffffffffffffffda RBX: 0000560c9d3059d0
>>>>>>> RCX: 00007fa743122e64
>>>>>>> May 05 00:59:02 kernel: RDX: 0000000000000000 RSI: 00007ffc48fa8de0
>>>>>>> RDI: 0000000000000006
>>>>>>> May 05 00:59:02 kernel: RBP: 0000560c9d3a9d10 R08: 0000000000000004
>>>>>>> R09: 0000000000000001
>>>>>>> May 05 00:59:02 kernel: R10: 00007ffc48fa8ec0 R11: 0000000000000202
>>>>>>> R12: 0000560c9d305cb0
>>>>>>> May 05 00:59:02 kernel: R13: 00007ffc48fa8de0 R14: 0000000000000000
>>>>>>> R15: 00007ffc48fa8ec0
>>>>>>> May 05 00:59:02 kernel:  </TASK>
>>>>>>> May 05 00:59:02 kernel: ---[ end trace 0000000000000000 ]---
>>>>>>> May 05 00:59:02 kernel: iwlwifi 0000:00:14.3: iwl_trans_wait_txq_empty
>>>>>>> bad state = 0
>>>>>>> May 05 00:59:02 wpa_supplicant[862]: wlan0: CTRL-EVENT-REGDOM-CHANGE
>>>>>>> init=DRIVER type=WORLD
>>>>>>> May 05 00:59:02 wpa_supplicant[862]: wlan0: CTRL-EVENT-SIGNAL-CHANGE
>>>>>>> above=1 signal=-46 noise=9999 txrate=26000
>>>>>>> May 05 00:59:03 wpa_supplicant[862]: TDLS: Creating peer entry for
>>>>>>> ca:0e:48:5e:0d:f2
>>>>>>> May 05 00:59:04 wpa_supplicant[862]: TDLS: Dialog Token in TPK M1 90
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Error sending ADD_STA:
>>>>>>> time out after 2000ms.
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Current CMD queue
>>>>>>> read_ptr 80 write_ptr 81
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Transport status:
>>>>>>> 0x0000004A, valid: 6
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Loaded firmware version:
>>>>>>> 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000084 |
>>>>>>> NMI_INTERRUPT_UNKNOWN
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0080A210 | trm_hw_status0
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x004CC44C | branchlink2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x004C2616 | interruptlink1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x004C2616 | interruptlink2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00014D94 | data1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x01000000 | data2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | data3
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x08C189F2 | beacon time
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x3766D630 | tsf low
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | time gp1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00379615 | time gp2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000004A | uCode version major
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0xA5E9588B | uCode version minor
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000351 | hw version
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x18C89001 | board version
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x80C8F400 | hcmd
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x24020000 | isr0
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x01000000 | isr1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x08F0000A | isr2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00C300CC | isr3
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | isr4
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0200001C | last cmd Id
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00014D94 | wait_event
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000080 | l2p_control
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00010034 | l2p_duration
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000003F | l2p_mhvalid
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x000000CE | l2p_addr_match
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | timestamp
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000A8A8 | flow_handler
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Transport status:
>>>>>>> 0x0000004A, valid: 7
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x80456052 | umac branchlink2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x804725A6 | umac interruptlink1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x804725A6 | umac interruptlink2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x01000000 | umac data1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x804725A6 | umac data2
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | umac data3
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000004A | umac major
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0xA5E9588B | umac minor
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00379613 | frame pointer
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00500118 | last host cmd
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: IML/ROM dump:
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00005751 | IML/ROM data1
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM
>>>>>>> WFPM_AUTH_KEY_0
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: Fseq Registers:
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00090006 |
>>>>>>> FSEQ_CNVIO_INIT_VERSION
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x00000003 |
>>>>>>> FSEQ_TOP_CONTENT_VERSION
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x05B0905B |
>>>>>>> CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: 0x0000025B |
>>>>>>> CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: WRT: Collecting data:
>>>>>>> ini trigger 4 fired (delay=0ms).
>>>>>>> May 05 00:59:06 kernel: ieee80211 phy0: Hardware restart was requested
>>>>>>> May 05 00:59:06 kernel: iwlwifi 0000:00:14.3: iwl_trans_wait_txq_empty
>>>>>>> bad state = 0
>>>>>>> May 05 00:59:11 wpa_supplicant[862]: wlan0: CTRL-EVENT-REGDOM-CHANGE
>>>>>>> init=DRIVER type=WORLD
>>>>>>> May 05 00:59:11 wpa_supplicant[862]: wlan0: CTRL-EVENT-SIGNAL-CHANGE
>>>>>>> above=1 signal=-46 noise=9999 txrate=26000
>>>>>>> May 05 00:59:20 wpa_supplicant[862]: wlan0: CTRL-EVENT-SIGNAL-CHANGE
>>>>>>> above=1 signal=-39 noise=9999 txrate=234000
>>>>>>>
>>>>>>>
>>>>>>> $ iperf3 -s
>>>>>>> -----------------------------------------------------------
>>>>>>> Server listening on 5201 (test #1)
>>>>>>> -----------------------------------------------------------
>>>>>>> Accepted connection from 192.168.1.121, port 45048
>>>>>>> [  5] local 192.168.1.179 port 5201 connected to 192.168.1.121 port 45058
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-1.00   sec  21.2 KBytes   174 Kbits/sec
>>>>>>> [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]  10.00-10.13  sec  0.00 Bytes  0.00 bits/sec
>>>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-10.13  sec  21.2 KBytes  17.2 Kbits/sec                  receiver
>>>>>>> -----------------------------------------------------------
>>>>>>> Server listening on 5201 (test #2)
>>>>>>> -----------------------------------------------------------
>>>>>>> Accepted connection from 192.168.1.121, port 52066
>>>>>>> [  5] local 192.168.1.179 port 5201 connected to 192.168.1.121 port 52082
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-1.00   sec  16.2 MBytes   136 Mbits/sec
>>>>>>> [  5]   1.00-2.00   sec  8.06 MBytes  67.5 Mbits/sec
>>>>>>> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec
>>>>>>> [  5]   8.00-9.00   sec  11.9 MBytes   100 Mbits/sec
>>>>>>> [  5]   9.00-10.00  sec  4.60 MBytes  38.6 Mbits/sec
>>>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-10.01  sec  40.8 MBytes  34.2 Mbits/sec                  receiver
>>>>>>>
>>>>>>>
>>>>>>> Linux 6.2.14, no crash, good performance:
>>>>>>> May 05 00:35:22 kernel: iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION:
>>>>>>> FSEQ Version: 89.3.35.37
>>>>>>> May 05 00:35:22 kernel: iwlwifi 0000:00:14.3: loaded firmware version
>>>>>>> 72.daa05125.0 QuZ-a0-hr-b0-72.ucode op_mode iwlmvm
>>>>>>> May 05 00:35:23 kernel: iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi
>>>>>>> 6 AX201 160MHz, REV=0x351
>>>>>>> May 05 00:35:23 kernel: iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
>>>>>>> May 05 01:03:35 wpa_supplicant[845]: TDLS: Creating peer entry for
>>>>>>> ca:0e:48:5e:0d:f2
>>>>>>> May 05 01:03:36 wpa_supplicant[845]: TDLS: Dialog Token in TPK M1 92
>>>>>>> May 05 01:03:36 wpa_supplicant[845]: nl80211: kernel reports: key
>>>>>>> addition failed
>>>>>>> May 05 01:03:36 wpa_supplicant[845]: TDLS: Failed to set TPK to the driver
>>>>>>> May 05 01:03:36 kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x2000707
>>>>>>>
>>>>>>> $ iperf3 -s
>>>>>>> -----------------------------------------------------------
>>>>>>> Server listening on 5201 (test #1)
>>>>>>> -----------------------------------------------------------
>>>>>>> Accepted connection from 192.168.1.121, port 39920
>>>>>>> [  5] local 192.168.1.179 port 5201 connected to 192.168.1.121 port 39934
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-1.00   sec  17.8 MBytes   149 Mbits/sec
>>>>>>> [  5]   1.00-2.00   sec  9.93 MBytes  83.3 Mbits/sec
>>>>>>> [  5]   2.00-3.00   sec  27.8 MBytes   233 Mbits/sec
>>>>>>> [  5]   3.00-4.00   sec  32.9 MBytes   276 Mbits/sec
>>>>>>> [  5]   4.00-5.00   sec  32.7 MBytes   274 Mbits/sec
>>>>>>> [  5]   5.00-6.00   sec  33.4 MBytes   280 Mbits/sec
>>>>>>> [  5]   6.00-7.00   sec  32.0 MBytes   269 Mbits/sec
>>>>>>> [  5]   7.00-8.00   sec  32.6 MBytes   273 Mbits/sec
>>>>>>> [  5]   8.00-9.00   sec  32.5 MBytes   273 Mbits/sec
>>>>>>> [  5]   9.00-10.00  sec  33.2 MBytes   278 Mbits/sec
>>>>>>> [  5]  10.00-10.04  sec  1.28 MBytes   270 Mbits/sec
>>>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>>>> [ ID] Interval           Transfer     Bitrate
>>>>>>> [  5]   0.00-10.04  sec   286 MBytes   239 Mbits/sec                  receiver
>>>>>>
>>>>>> Thanks for the report. It looks like there's some problem with TDLS.
>>>>>> I'd like to ask you to collect some debug data, if possible.
>>>>>> Firstly, please provide a firmware dump as per the instructions provided in [1].
>>>>>> Additionally, it would be helpful if you could test our latest driver from [2],
>>>>>> which contains commits that have not yet been submitted upstream. And the last
>>>>>> request - could you please open a bugzilla ticket and share the debug data there,
>>>>>> the process is also described in [1].
>>>>>>
>>>>>> [1] https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging
>>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git
>>>
>>>
> 
> 
